#!/usr/bin/env bats

load ../test_helper

#
# cd builtin
# "Change the current working directory to directory."
# https://www.gnu.org/software/bash/manual/bash.html#index-cd
#

@test 'directory created by the same user' {
   mkdir i-made-this

   run -0 cd i-made-this
}

@test 'directory without read bit' {
   mkdir no-read-bit
   chmod -r no-read-bit

   run -0 cd no-read-bit

   # cleanup will fail otherwise
   chmod +r no-read-bit
}

@test 'directory without write bit' {
   mkdir no-write-bit
   chmod -w no-write-bit

   run -0 cd no-write-bit
}

# Failure cases

@test 'fail: directory without execute bit' {
   mkdir no-exec-bit
   chmod -x no-exec-bit

   run -1 cd no-exec-bit
}

# TODO: directories owned by other users/groups
# TODO: CDPATH lookups
# TODO: -P
# TODO: -L
# TODO: -e
# TODO: -@
# TODO: -
