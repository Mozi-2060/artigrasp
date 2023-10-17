from ruamel.yaml import YAML, dump, RoundTripDumper
from raisimGymTorch.env.bin import multi_obj_arti as mano
from raisimGymTorch.env.RaisimGymVecEnv import RaisimGymVecEnv as VecEnv
from raisimGymTorch.helper.raisim_gym_helper import ConfigurationSaver, load_param, tensorboard_launcher
from raisimGymTorch.env.bin.multi_obj_arti import NormalSampler

import os
import time
import raisimGymTorch.algo.ppo.module as ppo_module
import raisimGymTorch.algo.ppo.ppo as PPO
import torch.nn as nn
import numpy as np
import torch
import argparse
from raisimGymTorch.helper import rotations, label_gen_final

data_version = "chiral_220223"

ref_r = [0.09566994, 0.00638343, 0.0061863]
ref_l = [-0.09566994, 0.00638343, 0.0061863]
path_mean_r = os.path.join("./../rsc/mano_double/right_pose_mean.txt")
path_mean_l = os.path.join("./../rsc/mano_double/left_pose_mean.txt")
pose_mean_r = np.loadtxt(path_mean_r)
pose_mean_l = np.loadtxt(path_mean_l)

exp_name = "multi_obj_arti"

y_adjust_l = 0
z_adjust_l = 0

ref_frame = 0
height_desk = 0.5
xpos_desk = 0.3

weight_saved = '2023-05-14-16-30-13/full_8600_r.pt'



# configuration
parser = argparse.ArgumentParser()
parser.add_argument('-c', '--cfg', help='config file', type=str, default='cfg_reg.yaml')
parser.add_argument('-m', '--mode', help='set mode either train or test', type=str, default='train')
parser.add_argument('-d', '--logdir', help='set dir for storing data', type=str, default=None)
parser.add_argument('-e', '--exp_name', help='exp_name', type=str, default=exp_name)
parser.add_argument('-w', '--weight', type=str, default=weight_saved)
parser.add_argument('-sd', '--storedir', type=str, default='data_all')
parser.add_argument('-pr', '--prior', action="store_true")
parser.add_argument('-o', '--obj_id', type=int, default=1)
parser.add_argument('-t', '--test', action="store_true")
parser.add_argument('-mc', '--mesh_collision', action="store_true")
parser.add_argument('-ao', '--all_objects', action="store_true")
parser.add_argument('-ev', '--evaluate', action="store_true")
parser.add_argument('-to', '--test_object_set', type=int, default=-1)
parser.add_argument('-ac', '--all_contact', action="store_true")
parser.add_argument('-seed', '--seed', type=int, default=1)
parser.add_argument('-itr', '--num_iterations', type=int, default=3001)
parser.add_argument('-nr', '--num_repeats', type=int, default=1)
parser.add_argument('-debug', '--debug', action="store_true")
parser.add_argument('-lr', '--log_rewards', action="store_true")
parser.add_argument('-random', '--random', help='randomized goal obj angle', action="store_true")
parser.add_argument('-renew', '--renew', help='update labels every iteration', action="store_true")
parser.add_argument('-obj', '--obj', help='which obj to test', type=str, default=None)
parser.add_argument('-record', '--record', help='record the state', action="store_true")

args = parser.parse_args()
mode = args.mode
weight_path = args.weight
record = args.record
cfg_grasp = args.cfg

print(f"Configuration file: \"{args.cfg}\"")
print(f"Experiment name: \"{args.exp_name}\"")

# task specification
task_name = args.exp_name
# check if gpu is available
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
# directories
task_path = os.path.dirname(os.path.realpath(__file__))
home_path = task_path + "/../../../../.."

if args.logdir is None:
    exp_path = home_path
else:
    exp_path = args.logdir

# config
cfg = YAML().load(open(task_path + '/cfgs/' + args.cfg, 'r'))

if args.seed != 1:
    cfg['seed'] = args.seed

num_envs = cfg['environment']['num_envs']
start_offset = 0
pre_grasp_steps = 100
trail_steps = 200
reward_clip = -2.0

num_repeats = args.num_repeats
activations = nn.LeakyReLU
output_activation = nn.Tanh

output_act = False
inference_flag = False
all_obj_train = True if args.all_objects else False
all_train = False
test_inference = args.test
train_obj_id = args.obj_id

obj_cmd = args.obj

shuffle_label = []
obj_label = {}
obj_label["seq_num"] = 9
obj_label["seq_name"] = "waffleiron_use_01"
obj_label["obj_name"] = "waffleiron"
obj_label["init_frame"] = 41
obj_label["grasp_frame"] = 60
obj_label["kind"] = "right_grasp"

shuffle_label.append(obj_label)

processed_data, obj_list, left_kind_list, right_kind_list = label_gen_final.pose_gen(shuffle_label, num_repeats, False)
print(obj_list)

stage_dim = processed_data[0]
stage_pos = processed_data[1]
obj_pose_reset = processed_data[2]
qpos_reset_r = processed_data[3]
qpos_reset_l = processed_data[4]
final_obj_angle = processed_data[5]
# final_obj_angle[:] = 0
final_obj_pos = processed_data[6]
final_obj_pos_r = processed_data[7]
final_ee_r = processed_data[8]
final_ee_l = processed_data[9]
final_pose_r = processed_data[10]
final_pose_l = processed_data[11]
final_qpos_r = processed_data[12]
final_qpos_l = processed_data[13]
final_contacts_r = processed_data[14]
final_contacts_l = processed_data[15]
final_obj_euler = processed_data[16]


num_envs = final_qpos_r.shape[0]
cfg['environment']['hand_model_r'] = "rhand_mano_meshcoll.urdf" if args.mesh_collision else "rhand_mano.urdf"
cfg['environment']['hand_model_l'] = "lhand_mano_meshcoll.urdf" if args.mesh_collision else "lhand_mano.urdf"
cfg['environment']['num_envs'] = 1 if args.evaluate else num_envs
if args.debug:
    cfg['environment']['num_envs'] = 1
cfg["testing"] = True if test_inference else False
print('num envs', num_envs)

# Environment definition
env = VecEnv(mano.RaisimGymEnv(home_path + "/rsc", dump(cfg['environment'], Dumper=RoundTripDumper)),
             cfg['environment'])
env.add_stage(stage_dim, stage_pos)

obj_path_list = []
for obj_item in obj_list:
    obj_path_list.append(os.path.join(f"{obj_item}/{obj_item}_fixed_base.urdf"))
env.load_multi_articulated(obj_path_list)

# Setting dimensions from environments
n_act = final_qpos_r[0].shape[0]
ob_dim_r = env.num_obs_r
act_dim = env.num_acts

# Training
grasp_steps = pre_grasp_steps
n_steps_r = grasp_steps + trail_steps
total_steps_r = n_steps_r * env.num_envs

avg_rewards = []
contact_rewards = []
impulse_rewards = []
pos_rewards = []
pose_rewards = []
falling_rewards = []
rel_obj_rewards = []
body_vel_rewards = []
body_qvel_rewards = []
obj_angle_rewards = []

# RL network

actor_r = ppo_module.Actor(
    ppo_module.MLP(cfg['architecture']['policy_net'], activations, ob_dim_r, act_dim),
    ppo_module.MultivariateGaussianDiagonalCovariance(act_dim, num_envs, 1.0, NormalSampler(act_dim)), device)

critic_r = ppo_module.Critic(ppo_module.MLP(cfg['architecture']['value_net'], activations, ob_dim_r, 1), device)


test_dir = True

saver = ConfigurationSaver(log_dir=exp_path + "/raisimGymTorch/" + args.storedir + "/" + task_name,
                           save_items=[task_path + "/cfgs/" + args.cfg, task_path + "/Environment.hpp",
                                       task_path + "/runner_eval.py", task_path + "/../../../helper/label_gen_final.py"], test_dir=test_dir)

ppo_r = PPO.PPO(actor=actor_r,
                critic=critic_r,
                num_envs=num_envs,
                num_transitions_per_env=n_steps_r,
                num_learning_epochs=4,
                gamma=0.996,
                lam=0.95,
                num_mini_batches=4,
                device=device,
                log_dir=saver.data_dir,
                shuffle_batch=False
                )

load_param(saver.data_dir.split('eval')[0]+weight_path, env, actor_r, critic_r, ppo_r.optimizer, saver.data_dir, cfg_grasp)

if mode == 'retrain' or args.evaluate:
    load_param(saver.data_dir.split('eval')[0] + weight_path, env, actor_r, critic_r, ppo_r.optimizer, saver.data_dir,
               args.cfg)

if args.debug:
    qpos_reset_r = final_qpos_r
    obj_pose_reset = final_obj_pos

env.reset_state(qpos_reset_r,
                qpos_reset_l,
                np.zeros((num_envs, 51), 'float32'),
                np.zeros((num_envs, 51), 'float32'),
                obj_pose_reset,
                )
# time.sleep(1200)
env.set_goals(final_obj_angle,
              final_obj_pos,
              final_ee_r,
              final_ee_l,
              final_pose_r,
              final_pose_l,
              final_qpos_r,
              final_qpos_l,
              final_contacts_r,
              final_contacts_l,
              )
env.reset_state(qpos_reset_r,
                qpos_reset_l,
                np.zeros((num_envs, 51), 'float32'),
                np.zeros((num_envs, 51), 'float32'),
                obj_pose_reset
                )
if args.debug:
    time.sleep(1200)

if record:
    trans_r = np.zeros((n_steps_r, 3))
    rot_r = np.zeros((n_steps_r, 3))
    pose_r = np.zeros((n_steps_r, 45))
    trans_obj = np.zeros((n_steps_r, 3))
    rot_obj = np.zeros((n_steps_r, 3))
    angle_obj = np.zeros((n_steps_r, 1))

for update in range(args.num_iterations):
    start = time.time()

    reward_angle_sum = 0
    reward_ll_sum_r = 0
    reward_ll_sum_l = 0
    done_sum = 0
    average_dones = 0.

    contact_reward_r = 0
    impulse_reward_r = 0
    pos_reward_r = 0
    pose_reward_r = 0
    obj_angle_reward_r = 0
    body_vel_reward_r = 0
    body_qvel_reward_r = 0

    ### Evaluate trained model visually (note always the first environment gets visualized)

    if update % cfg['environment']['eval_every_n'] == 0:
        print("Visualizing and evaluating the current policy")
        torch.save({
            'actor_architecture_state_dict': actor_r.architecture.state_dict(),
            'actor_distribution_state_dict': actor_r.distribution.state_dict(),
            'critic_architecture_state_dict': critic_r.architecture.state_dict(),
            'optimizer_state_dict': ppo_r.optimizer.state_dict(),
        }, saver.data_dir + "/full_" + str(update) + '_r.pt')

        env.save_scaling(saver.data_dir, str(update))

    renew_labels = []
    obj_name = obj_list[0]

    shuffle_label = []
    obj_label = {}
    obj_label["seq_num"] = 9
    obj_label["seq_name"] = "waffleiron_use_01"
    obj_label["obj_name"] = "waffleiron"
    obj_label["init_frame"] = 41
    obj_label["grasp_frame"] = 60
    obj_label["kind"] = "right_grasp"
    shuffle_label.append(obj_label)
    processed_data, obj_list, left_kind_list, right_kind_list = label_gen_final.pose_gen(shuffle_label, num_repeats,
                                                                                         False)
    stage_dim = processed_data[0]
    stage_pos = processed_data[1]
    obj_pose_reset = processed_data[2]
    qpos_reset_r = processed_data[3]
    qpos_reset_l = processed_data[4]
    final_obj_angle = processed_data[5]
    # final_obj_angle[:] = 0
    final_obj_pos = processed_data[6]
    final_obj_pos_r = processed_data[7]
    final_ee_r = processed_data[8]
    final_ee_l = processed_data[9]
    final_pose_r = processed_data[10]
    final_pose_l = processed_data[11]
    final_qpos_r = processed_data[12]
    final_qpos_l = processed_data[13]
    final_contacts_r = processed_data[14]
    final_contacts_l = processed_data[15]
    final_obj_euler = processed_data[16]

    print(final_contacts_r)

    env.set_goals(final_obj_angle,
                  final_obj_pos,
                  final_ee_r,
                  final_ee_l,
                  final_pose_r,
                  final_pose_l,
                  final_qpos_r,
                  final_qpos_l,
                  final_contacts_r,
                  final_contacts_l,
                  )

    ### Add some noise to goal angle
    random_noise_angle = final_obj_angle.copy()
    rand_temp = np.float32(np.random.uniform(0.5, 1.5, (num_envs, 1)).copy())
    for i in range(num_envs):
        if right_kind_list[i] == 8:
            random_noise_angle[i] = rand_temp[i]
        else:
            random_noise_angle[i] = final_obj_angle[i]
    print(f"ave goal angle: {np.sum(np.abs(random_noise_angle)) / num_envs}")
    env.set_goals(random_noise_angle,
                  final_obj_pos,
                  final_ee_r,
                  final_ee_l,
                  final_pose_r,
                  final_pose_l,
                  final_qpos_r,
                  final_qpos_l,
                  final_contacts_r,
                  final_contacts_l,
                  )

    ### Add some noise to initial hand position
    random_noise_pos = np.float32(np.random.uniform([-0.05, -0.05, 0.05], [0.05, 0.05, 0.05], (num_envs, 3)).copy())
    random_noise_qpos = np.float32(np.random.uniform(-0.1, 0.1, (num_envs, 48)).copy())
    qpos_noisy_reset_r = qpos_reset_r.copy()
    qpos_noisy_reset_l = qpos_reset_l.copy()

    env.reset_state(qpos_noisy_reset_r,
                    qpos_noisy_reset_l,
                    np.zeros((num_envs, 51), 'float32'),
                    np.zeros((num_envs, 51), 'float32'),
                    obj_pose_reset
                    )

    left_kinds = np.float32(left_kind_list.copy())
    right_kinds = np.float32(right_kind_list.copy())

    env.control_switch_all(left_kinds, right_kinds)

    for step in range(n_steps_r):
        obs_r, obs_l = env.observe()
        obs_r = obs_r[:, :].astype('float32')


        if record:
            trans_r[step, :] = obs_l[0, :3] - ref_r
            axis, angle = rotations.quat2axisangle(obs_l[0, 3:7])
            rot_r[step, :] = axis * angle
            pose_r[step, :] = obs_l[0, 7:52] - pose_mean_r

            trans_obj[step, :] = obj_pose_reset[0, :3]
            axis, angle = rotations.quat2axisangle(obj_pose_reset[0, 3:7])
            rot_obj[step, :] = axis * angle
            angle_obj[step, :] = obs_r[0, -3]

        if np.isnan(obs_r).any():
            np.savetxt(saver.data_dir + "/nan_obs.txt", obs_r)

        action_r = actor_r.architecture.architecture(torch.from_numpy(obs_r.astype('float32')).to(device))
        action_l = torch.zeros_like(action_r)

        action_grasp_r = action_r.cpu().detach().numpy()
        action_grasp_l = action_l.cpu().detach().numpy()
        frame_start = time.time()


        reward_r, _, dones = env.step(action_grasp_r.astype('float32'), action_grasp_l.astype('float32'))

        reward_angle_sum += np.sum(np.abs(obs_r[:, -1]))

        done_sum = done_sum + np.sum(dones)

        frame_end = time.time()
        wait_time = cfg['environment']['control_dt'] - (frame_end - frame_start)
        if wait_time > 0.:
            time.sleep(wait_time)

    print(reward_angle_sum / total_steps_r)
    print("end")


    if record:
        pose_r[:, -27:-18] =0
        trans_r[100:] = trans_r[100]
        rot_r[100:] = rot_r[100]
        pose_r[100:] = pose_r[100]

        data = {}
        data['right_hand'] = {}
        data['waffleiron'] = {}
        data['right_hand']['trans'] = np.float32(trans_r)
        data['right_hand']['rot'] = np.float32(rot_r)
        data['right_hand']['pose'] = np.float32(pose_r)
        data['waffleiron']['trans'] = np.float32(trans_obj)
        data['waffleiron']['rot'] = np.float32(rot_obj)
        data['waffleiron']['angle'] = np.float32(angle_obj)
        np.save(f"./data_all/recorded/ours_fixed/{obj_name}_fixed_right.npy", data)
        print("recorded")

if args.store_video:
    print('store video')
    env.stop_video_recording()
    env.turn_off_visualization()
