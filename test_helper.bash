#!/usr/bin/env bash

# brew tap kaos/shell
# brew install bats-assert bats-file bats-support
BREW_PREFIX="$(brew --prefix)"
load "${BREW_PREFIX}/lib/bats-support/load.bash"
load "${BREW_PREFIX}/lib/bats-assert/load.bash"
load "${BREW_PREFIX}/lib/bats-file/load.bash"

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
