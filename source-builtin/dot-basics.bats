#!/usr/bin/env bats

load ../test_helper

#
# Clone of source-builtin/basics.bats testing "." instead of "source"
#

@test 'runs code in current directory context' {
   mkdir nested
   printf 'echo "hi, i am a file" > file-written' > nested/writes-a-file

   run -0 . ./nested/writes-a-file
   assert_file_exists     file-written
   assert_file_not_exists nested/file-written
}

@test 'adds variables to current shell' {
   printf 'variable_via_sourced_file="excellent value"' > creates-variable

   # bash 4.2+ can be more exact with [[ ! -v variable_via_sourced_file ]]
   [[ -z ${variable_via_sourced_file:-} ]]
   . ./creates-variable
   [[ $variable_via_sourced_file == "excellent value" ]]
}

@test 'adds function' {
   printf 'heard_at_juniors() { echo "Cocteau Twins"; }' > creates-function

   run -1 type heard_at_juniors
   . ./creates-function
   run type heard_at_juniors
   assert_line 'heard_at_juniors is a function'
}

@test 'only adds alias in interactive shell' {
   printf 'alias lego_train="el tren"' > creates-alias

   run -1 bash -c '. ./creates-alias; type lego_train'
   run -0 bash -ci '. ./creates-alias; type lego_train'
}

@test "current process exits when source'ing an exit" {
   # It's a little tricky to elegantly prove this behavior in a test; for now this will do.
   printf 'exit 3' > exit-3
   printf 'echo before; . ./exit-3; echo after' > uses-exit-3

   run -3 source ./uses-exit-3
   assert_line before
   refute_line after
}

# Failure cases

@test 'fail: when filename does not exist' {
   run -1 . ./this-file-is-missing
}
