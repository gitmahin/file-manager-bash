#!/usr/bin/env bats

bats_load_safe "helper.bash"

setup(){
  setup_testing_ground
  setup_common_assertion
  setup_file_assertion
}

# this hook will run after all tests have finished 
# teardown() {
  
# }

@test "Testing ==> copy-files.bats" {
  run bats "src/tests/copy-files.bats"
  assert_success
}

@test "Testing ==> create-files.bats" {
  run bats "src/tests/create-files.bats"
  assert_success
}

@test "Testing ==> create-folders.bats" {
  run bats "src/tests/create-folders.bats"
  assert_success
}




