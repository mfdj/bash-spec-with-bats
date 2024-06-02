#!/usr/bin/env bash

# brew tap bats-core/bats-core
# brew install bats-assert bats-file bats-support
BATS_LIB_PATH="$BATS_LIB_PATH:$(brew --prefix)/lib"
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-support

#
# Global setup/teardown to run before/after every test.
#
# If cutomization is needed per test file prefix these functions and call them
# individually from each file.
#

setup() {
   set -o nounset # BATS sets errexit

   export TEST_DIR
   TEST_DIR=$(mktemp -d -t 'bash-spec-with-bats')
   cd "$TEST_DIR" || {
      echo 'Failed to generate TEST_DIR'
      exit 1
   }
}

teardown() {
  # Clean up each run; uncomment this line to debug issues in tests
  rm -rf "${TEST_DIR:?}"
}
