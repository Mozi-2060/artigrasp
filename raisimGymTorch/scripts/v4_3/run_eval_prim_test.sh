#!/bin/sh
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 1 -e '002_can_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'         -w '2021-11-08-22-23-11/full_800.pt'  -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 2 -e '003_crackerbox_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'  -w '2021-11-08-22-23-14/full_1800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 3 -e '004_sugarbox_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'    -w '2021-11-08-22-24-07/full_600.pt'  -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 4 -e '005_tomatocan_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'   -w '2021-11-08-22-23-24/full_2000.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 5 -e '006_mustard_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-26/full_2800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 6 -e '007_tunacan_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-15/full_1600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 7 -e '008_pudding_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-13/full_3000.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 8 -e '009_gelatin_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-16/full_3000.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 9 -e '010_pottedcan_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'   -w '2021-11-08-22-23-14/full_1800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 10 -e '011_banana_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-07/full_2400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 11 -e '019_pitcher_extstate_v4_3' -c 'cfg_reg.yaml'  -sd 'data_v4_3'   -w '2021-11-08-22-23-31/full_2400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 12 -e '021_bleach_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-18/full_2400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 13 -e '024_bowl_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'       -w '2021-11-08-22-23-12/full_2600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 14 -e '025_mug_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'        -w '2021-11-08-21-59-27/full_2800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 15 -e '035_powerdrill_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3' -w '2021-11-08-22-22-49/full_2600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 16 -e '036_woodblock_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'  -w '2021-11-08-22-07-19/full_800.pt'  -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 17 -e '037_scissors_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'   -w '2021-11-08-22-22-48/full_1400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 18 -e '040_marker_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-22/full_2200.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 20 -e '052_clamp_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'      -w '2021-11-08-22-23-11/full_2200.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/runner_eval.py -o 21 -e '061_foam_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'       -w '2021-11-08-22-23-30/full_2600.pt' -p -t

python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 1 -e '002_can_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'         -w '2021-11-08-22-23-11/full_800.pt'  -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 2 -e '003_crackerbox_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'  -w '2021-11-08-22-23-14/full_1800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 3 -e '004_sugarbox_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'    -w '2021-11-08-22-24-07/full_600.pt'  -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 4 -e '005_tomatocan_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'   -w '2021-11-08-22-23-24/full_2000.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 5 -e '006_mustard_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-26/full_2800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 6 -e '007_tunacan_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-15/full_1600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 7 -e '008_pudding_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-15/full_1600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 8 -e '009_gelatin_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-13/full_3000.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 9 -e '010_pottedcan_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'   -w '2021-11-08-22-23-16/full_3000.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 10 -e '011_banana_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-14/full_1800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 11 -e '019_pitcher_extstate_v4_3' -c 'cfg_reg.yaml'  -sd 'data_v4_3'   -w '2021-11-08-22-23-07/full_2400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 12 -e '021_bleach_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-23-31/full_2800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 13 -e '024_bowl_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'       -w '2021-11-08-22-23-18/full_2400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 14 -e '025_mug_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'        -w '2021-11-08-22-23-12/full_2600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 15 -e '035_powerdrill_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3' -w '2021-11-08-21-59-27/full_2800.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 16 -e '036_woodblock_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'  -w '2021-11-08-22-22-49/full_2600.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 17 -e '037_scissors_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'   -w '2021-11-08-22-07-19/full_800.pt'  -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 18 -e '040_marker_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'     -w '2021-11-08-22-22-48/full_1400.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 20 -e '052_clamp_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'      -w '2021-11-08-22-23-22/full_2200.pt' -p -t
python raisimGymTorch/env/envs/mano_eval/eval_scores.py -o 21 -e '061_foam_extstate_v4_3' -c 'cfg_reg.yaml' -sd 'data_v4_3'       -w '2021-11-08-22-23-11/full_2200.pt' -p -t