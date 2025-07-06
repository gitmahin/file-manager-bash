# !/usr/bin/env bats
# bats file_tags=copy-folders

bats_load_safe "helper.bash"

setup(){
    setup_testing_ground
    setup_common_assertion
    setup_file_assertion

    export folder_name="my-folder"
    export number_of_command=5

    mkdir "$folder_name"
}

teardown() {
  tear_down_file    
}

# bats test_tags=copy-folders-default
@test "Should copy folders 2 to 6 with default settings" {
    run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFolders "$folder_name" "$number_of_command"'
    echo "OUTPUT: <$output>"
    
    assert_success

    assert_dir_exists "my-folder-2" 
    assert_dir_exists "my-folder-3" 
    assert_dir_exists "my-folder-4" 
    assert_dir_exists "my-folder-5" 
    assert_dir_exists "my-folder-6" 
}

# bats test_tags=copy-folders-modified
@test "Should copy folders 6 to 10 with modified settings without output folder name" {
    export numbering_position="l"
    export start_numbering_from="6"

    run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFolders "$folder_name" "$number_of_command" "$numbering_position" "$start_numbering_from"'
    echo "OUTPUT: <$output>"

    assert_success

    assert_dir_exists "6-my-folder" 
    assert_dir_exists "7-my-folder" 
    assert_dir_exists "8-my-folder" 
    assert_dir_exists "9-my-folder" 
    assert_dir_exists "10-my-folder" 
}

# bats test_tags=copy-folders-output-name
@test "Should copy folders 2 to 6 with custom output folder name and default settings" {
    export output_folder_name="custom-folder"

    run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFolders "$folder_name" "$number_of_command" "" "" "$output_folder_name"'
    echo "OUTPUT: <$output>"

    assert_success

    assert_dir_exists "custom-folder-2" 
    assert_dir_exists "custom-folder-3" 
    assert_dir_exists "custom-folder-4" 
    assert_dir_exists "custom-folder-5" 
    assert_dir_exists "custom-folder-6" 
}

# bats test_tags=copy-folders-not-found
@test "Should return error if no folder name is provided" {
    run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFolders ""'
    echo "OUTPUT: <$output>"
    assert_failure
}