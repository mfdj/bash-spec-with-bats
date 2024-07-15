#!/usr/bin/env bats

load ../test_helper

setup() {
   default_setup
   mkdir add-to-path
   printf 'echo found from path lookup' > add-to-path/look-me-up
}

@test 'when filename does not contain a slash PATH is consulted' {
   assert_file_not_exists look-me-up
   run -1 source look-me-up

   export PATH="$PATH:add-to-path"
   run -0 source look-me-up
   assert_line 'found from path lookup'
}

@test 'dot: when filename does not contain a slash PATH is consulted' {
   export PATH="$PATH:add-to-path"
   run -0 . look-me-up
   assert_line 'found from path lookup'
}

@test 'PATH has precdence with slashless filename' {
   printf 'echo from current directory' > look-me-up

   # resolves from current directory
   run source look-me-up
   assert_line 'from current directory'

   # resolves from add-to-path directory
   export PATH="$PATH:add-to-path"
   run source look-me-up
   assert_line 'found from path lookup'
}

@test 'POSIX mode slashless filename does not consult current directory' {
   touch local-file

   # fails in posix mode
   set -o posix
   run -1 source local-file
   run -1 . local-file

   # works when NOT in posix mode
   set +o posix
   run -0 source local-file
   run -0 . local-file
}
