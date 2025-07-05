#!/usr/bin/env bats
# bats file_tags=create-folders

bats_load_safe "helper.bash"

setup() {
  setup_testing_ground
  setup_common_assertion
  setup_file_assertion
}

# bats test_tags=create-folders-leftn
@test "Should create folders 1 to 3 with left numbering position" {
  export folder_name="myfolder"
  export number_of_command=3
  export numbering_position="l"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  echo "OUTPUT: <$output>"
  assert_success

  assert_dir_exists "1-myfolder"
  assert_dir_exists "2-myfolder"
  assert_dir_exists "3-myfolder"
}

# bats test_tags=create-folders-rightn
@test "Should create folders 1 to 3 with right numbering position" {
  export folder_name="myfolder"
  export number_of_command=3
  export numbering_position="r"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  echo "OUTPUT: <$output>"
  assert_success

  assert_dir_exists "myfolder-1"
  assert_dir_exists "myfolder-2"
  assert_dir_exists "myfolder-3"
}

# bats test_tags=create-folders-undefined
@test "Should return error if no folder name is provided" {
  export folder_name=""
  export number_of_command=3
  export numbering_position="r"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  echo "OUTPUT: <$output>"

  # cause createFolders with empty file name is returning 1. 
  # so we have to use assert_failure instead of assert_success cause assert_success find 0
  # so if we pass 1 to assert_success our test will fail.
  # but assert_failure will success as it dont take 0
  assert_failure
}