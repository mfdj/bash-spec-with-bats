#!/usr/bin/env bats

load ../test_helper

#
# pushd builtin
# "Adds a directory to the top of the directory stack, or rotates the stack, making the new top of the stack the current working directory."
# https://www.gnu.org/software/bash/manual/bash.html#index-directory-stack
#

@test 'directory created by the same user' {
   mkdir i-made-this

   run -0 pushd i-made-this
}

@test 'directory without read bit' {
   mkdir no-read-bit
   chmod -r no-read-bit

   run -0 pushd no-read-bit

   # cleanup will fail otherwise
   chmod +r no-read-bit
}

@test 'directory without write bit' {
   mkdir no-write-bit
   chmod -w no-write-bit

   run -0 pushd no-write-bit
}

# Failure cases

@test 'fail: directory without execute bit' {
   mkdir no-exec-bit
   chmod -x no-exec-bit

   run -1 pushd no-exec-bit
}
