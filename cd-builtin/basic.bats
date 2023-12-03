#!/usr/bin/env bats

load ../test_helper

#
# cd builtin
# "Change the current working directory to directory."
# https://www.gnu.org/software/bash/manual/bash.html#index-cd
#

@test 'directory created by the same user' {
   mkdir i-made-this

   run cd i-made-this
   assert_success
}

@test 'directory without read bit' {
   mkdir no-read-bit
   chmod -r no-read-bit

   run cd no-read-bit
   assert_success

   # cleanup will fail otherwise
   chmod +r no-read-bit
}

@test 'directory without write bit' {
   mkdir no-write-bit
   chmod -w no-write-bit

   run cd no-write-bit
   assert_success
}

# Failure cases

@test 'fail: directory without execute bit' {
   mkdir no-exec-bit
   chmod -x no-exec-bit

   run cd no-exec-bit
   assert_failure
}

# TODO: directories owned by other users/groups
# TODO: CDPATH lookups
# TODO: -P
# TODO: -L
# TODO: -e
# TODO: -@
# TODO: -
