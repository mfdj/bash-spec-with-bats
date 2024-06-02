#!/usr/bin/env bats

load ../test_helper

#
# pushd builtin
# "Adds a directory to the top of the directory stack, or rotates the stack, making the new top of the stack the current working directory."
# https://www.gnu.org/software/bash/manual/bash.html#index-directory-stack
#

@test 'directory created by the same user' {
   mkdir i-made-this

   run pushd i-made-this
   assert_success
}

@test 'directory without read bit' {
   mkdir no-read-bit
   chmod -r no-read-bit

   run pushd no-read-bit
   assert_success

   # cleanup will fail otherwise
   chmod +r no-read-bit
}

@test 'directory without write bit' {
   mkdir no-write-bit
   chmod -w no-write-bit

   run pushd no-write-bit
   assert_success
}

# Failure cases

@test 'fail: directory without execute bit' {
   mkdir no-exec-bit
   chmod -x no-exec-bit

   run pushd no-exec-bit
   assert_failure
}
