# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/huizhang/intern/venv_dgrasp/lib/python3.8/site-packages/cmake/data/bin/cmake

# The command to remove a file.
RM = /home/huizhang/intern/venv_dgrasp/lib/python3.8/site-packages/cmake/data/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/huizhang/intern/raisim_grasp_arctic

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch

# Include any dependencies generated for this target.
include examples/CMakeFiles/materials.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/CMakeFiles/materials.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/materials.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/materials.dir/flags.make

examples/CMakeFiles/materials.dir/src/server/material.cpp.o: examples/CMakeFiles/materials.dir/flags.make
examples/CMakeFiles/materials.dir/src/server/material.cpp.o: /home/huizhang/intern/raisim_grasp_arctic/examples/src/server/material.cpp
examples/CMakeFiles/materials.dir/src/server/material.cpp.o: examples/CMakeFiles/materials.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/materials.dir/src/server/material.cpp.o"
	cd /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/CMakeFiles/materials.dir/src/server/material.cpp.o -MF CMakeFiles/materials.dir/src/server/material.cpp.o.d -o CMakeFiles/materials.dir/src/server/material.cpp.o -c /home/huizhang/intern/raisim_grasp_arctic/examples/src/server/material.cpp

examples/CMakeFiles/materials.dir/src/server/material.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/materials.dir/src/server/material.cpp.i"
	cd /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/huizhang/intern/raisim_grasp_arctic/examples/src/server/material.cpp > CMakeFiles/materials.dir/src/server/material.cpp.i

examples/CMakeFiles/materials.dir/src/server/material.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/materials.dir/src/server/material.cpp.s"
	cd /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/huizhang/intern/raisim_grasp_arctic/examples/src/server/material.cpp -o CMakeFiles/materials.dir/src/server/material.cpp.s

# Object files for target materials
materials_OBJECTS = \
"CMakeFiles/materials.dir/src/server/material.cpp.o"

# External object files for target materials
materials_EXTERNAL_OBJECTS =

examples/materials: examples/CMakeFiles/materials.dir/src/server/material.cpp.o
examples/materials: examples/CMakeFiles/materials.dir/build.make
examples/materials: /home/huizhang/intern/raisim_grasp_arctic/raisim/linux/lib/libraisim.so.1.1.6
examples/materials: /home/huizhang/intern/raisim_grasp_arctic/raisim/linux/lib/libraisimPng.so
examples/materials: /home/huizhang/intern/raisim_grasp_arctic/raisim/linux/lib/libraisimZ.so
examples/materials: /home/huizhang/intern/raisim_grasp_arctic/raisim/linux/lib/libraisimODE.so.1.1.6
examples/materials: /home/huizhang/intern/raisim_grasp_arctic/raisim/linux/lib/libraisimMine.so
examples/materials: examples/CMakeFiles/materials.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable materials"
	cd /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/materials.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/materials.dir/build: examples/materials
.PHONY : examples/CMakeFiles/materials.dir/build

examples/CMakeFiles/materials.dir/clean:
	cd /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples && $(CMAKE_COMMAND) -P CMakeFiles/materials.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/materials.dir/clean

examples/CMakeFiles/materials.dir/depend:
	cd /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/huizhang/intern/raisim_grasp_arctic /home/huizhang/intern/raisim_grasp_arctic/examples /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples /home/huizhang/intern/raisim_grasp_arctic/raisimGymTorch/examples/CMakeFiles/materials.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/materials.dir/depend

