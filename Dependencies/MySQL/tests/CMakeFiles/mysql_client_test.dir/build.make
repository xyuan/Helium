# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.6

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canoncical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/cteam/BuildStepper/bootstrap-dep/inst/bin/cmake

# The command to remove a file.
RM = /home/cteam/BuildStepper/bootstrap-dep/inst/bin/cmake -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /home/cteam/BuildStepper/bootstrap-dep/inst/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /tmp/bootstrap-dir.5535/source

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /tmp/bootstrap-dir.5535/source

# Include any dependencies generated for this target.
include tests/CMakeFiles/mysql_client_test.dir/depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/mysql_client_test.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/mysql_client_test.dir/flags.make

tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o: tests/CMakeFiles/mysql_client_test.dir/flags.make
tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o: tests/mysql_client_test.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/bootstrap-dir.5535/source/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o"
	cd /tmp/bootstrap-dir.5535/source/tests && /usr/sfw/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o   -c /tmp/bootstrap-dir.5535/source/tests/mysql_client_test.c

tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mysql_client_test.dir/mysql_client_test.c.i"
	cd /tmp/bootstrap-dir.5535/source/tests && /usr/sfw/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /tmp/bootstrap-dir.5535/source/tests/mysql_client_test.c > CMakeFiles/mysql_client_test.dir/mysql_client_test.c.i

tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mysql_client_test.dir/mysql_client_test.c.s"
	cd /tmp/bootstrap-dir.5535/source/tests && /usr/sfw/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /tmp/bootstrap-dir.5535/source/tests/mysql_client_test.c -o CMakeFiles/mysql_client_test.dir/mysql_client_test.c.s

tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.requires:
.PHONY : tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.requires

tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.provides: tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.requires
	$(MAKE) -f tests/CMakeFiles/mysql_client_test.dir/build.make tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.provides.build
.PHONY : tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.provides

tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.provides.build: tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o
.PHONY : tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.provides.build

tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o: tests/CMakeFiles/mysql_client_test.dir/flags.make
tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o: mysys/my_memmem.c
	$(CMAKE_COMMAND) -E cmake_progress_report /tmp/bootstrap-dir.5535/source/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o"
	cd /tmp/bootstrap-dir.5535/source/tests && /usr/sfw/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o   -c /tmp/bootstrap-dir.5535/source/mysys/my_memmem.c

tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.i"
	cd /tmp/bootstrap-dir.5535/source/tests && /usr/sfw/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /tmp/bootstrap-dir.5535/source/mysys/my_memmem.c > CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.i

tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.s"
	cd /tmp/bootstrap-dir.5535/source/tests && /usr/sfw/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /tmp/bootstrap-dir.5535/source/mysys/my_memmem.c -o CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.s

tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.requires:
.PHONY : tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.requires

tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.provides: tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.requires
	$(MAKE) -f tests/CMakeFiles/mysql_client_test.dir/build.make tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.provides.build
.PHONY : tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.provides

tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.provides.build: tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o
.PHONY : tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.provides.build

# Object files for target mysql_client_test
mysql_client_test_OBJECTS = \
"CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o" \
"CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o"

# External object files for target mysql_client_test
mysql_client_test_EXTERNAL_OBJECTS =

tests/mysql_client_test: tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o
tests/mysql_client_test: tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o
tests/mysql_client_test: libmysql/libmysqlclient.a
tests/mysql_client_test: /lib/libm.so
tests/mysql_client_test: /lib/libsocket.so
tests/mysql_client_test: tests/CMakeFiles/mysql_client_test.dir/build.make
tests/mysql_client_test: tests/CMakeFiles/mysql_client_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable mysql_client_test"
	cd /tmp/bootstrap-dir.5535/source/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mysql_client_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/mysql_client_test.dir/build: tests/mysql_client_test
.PHONY : tests/CMakeFiles/mysql_client_test.dir/build

tests/CMakeFiles/mysql_client_test.dir/requires: tests/CMakeFiles/mysql_client_test.dir/mysql_client_test.c.o.requires
tests/CMakeFiles/mysql_client_test.dir/requires: tests/CMakeFiles/mysql_client_test.dir/__/mysys/my_memmem.c.o.requires
.PHONY : tests/CMakeFiles/mysql_client_test.dir/requires

tests/CMakeFiles/mysql_client_test.dir/clean:
	cd /tmp/bootstrap-dir.5535/source/tests && $(CMAKE_COMMAND) -P CMakeFiles/mysql_client_test.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/mysql_client_test.dir/clean

tests/CMakeFiles/mysql_client_test.dir/depend:
	cd /tmp/bootstrap-dir.5535/source && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/bootstrap-dir.5535/source /tmp/bootstrap-dir.5535/source/tests /tmp/bootstrap-dir.5535/source /tmp/bootstrap-dir.5535/source/tests /tmp/bootstrap-dir.5535/source/tests/CMakeFiles/mysql_client_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/mysql_client_test.dir/depend
