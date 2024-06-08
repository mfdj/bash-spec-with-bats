#!/usr/bin/env bash

# brew tap bats-core/bats-core
# brew install bats-assert bats-file bats-support
BATS_LIB_PATH="$BATS_LIB_PATH:$(brew --prefix)/lib"
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-support

default_setup() {
   set -o nounset # This ensures no unset variables are used in test block (BATS sets errexit)

   # BATS generates several empty directories under BATS_RUN_TMPDIR:
   #  • BATS_SUITE_TMPDIR for the whole test suite
   #  • BATS_FILE_TMPDIR unique per test file
   #  • BATS_TEST_TMPDIR unique per @test block
   # Use `bats … --no-tempdir-cleanup` to retain BATS_RUN_TMPDIR and inspect the artifacts

   # Default to the directory generated per @test block; individual tests can override this behavior
   pushd "$BATS_TEST_TMPDIR" || {
      echo 'Failed to change to BATS_TEST_TMPDIR'
      exit 1
   }
}

#
# Setup is run before every test.
# If customization is needed per file override this function.
#
setup() {
   default_setup
}
