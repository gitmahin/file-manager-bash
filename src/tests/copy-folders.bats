# !/usr/bin/env bats
# bats file_tags=copy-folders

bats_load_safe "helper.bash"

setup(){
    setup_testing_ground
    setup_common_assertion
    setup_file_assertion
}

@test "Should copy folders 2 to 6 without custom output file-name and with default settings" {
    export folder_name="my-folder"
    export number_of_command=5

    cd "$BATS_TMPDIR" || exit 1
    mkdir "$folder_name"

    run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFolders "$folder_name" "$number_of_command"'
    echo "OUTPUT: <$output>"

    assert_success

    assert_dir_exists "my-folder-2" 
    assert_dir_exists "my-folder-3" 
    assert_dir_exists "my-folder-4" 
    assert_dir_exists "my-folder-5" 
    assert_dir_exists "my-folder-6" 
}