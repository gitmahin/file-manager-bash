# !/bin/bash

# can create bulk serial files and folders 1, 2, 3
# can create multiple files and folders
# can zip unzip files and folders

START_SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "$START_SCRIPT_DIR/lib.sh"
source "$START_SCRIPT_DIR/utils.sh"
source "$START_SCRIPT_DIR/constants.sh"

option=""

cat << EOF
***********************************
====Welcome To The Filemanager=====
***********************************
Select a task to perform.
1. $create_file
2. $create_folders
EOF

read -p "Choose a task - [1/2/3]: " option

# xargs to trim leading/trailing whitespace
case $(echo "$option" | xargs) in
    "1")
        # selected message
        terminalMessage select "$create_file"
        # choose options
        optionsListMessage "Select which task to perform" \
        ""\
        "$(cat << EOF 
1. $copy_create
2. $create_new
EOF
        )"

        option=$(optionSelector "[1/2]")
        case $(echo "$option" | xargs) in
            "1")
                # COPY AND CREATE FILES
                terminalMessage select "$copy_create"

                # get core values 
                IFS="," read -r file_name number_of_command numbering_position start_numbering_from <<< "$( getFileFldCreationInput "file" )"
                output_file_name="$( modifyFileFldCopyCreationInput "file" )"

                # user commands
                getCommandPreviewForFilesFld "file" "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from"
                getModifyDefaultCommandPreview "file" "$output_file_name"
                askToContinue
                copyNCreateFiles "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from" "$output_file_name"
                
                [[ $? == 1 ]] && exit 1
                ;;
            "2")
                # FILES CREATION
                terminalMessage select "$create_new"

                # get core values
                IFS="," read -r file_name number_of_command numbering_position start_numbering_from <<< "$( getFileFldCreationInput "file" )"
                # user commands
                getCommandPreviewForFilesFld "file" "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from"
                askToContinue
                createFiles "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from"
                [[ $? == 1 ]] && exit 1
                ;;
            *)
                exit 1
                ;;
        esac
        ;;
    "2")
        # selected message
        terminalMessage select "$create_folders"

        optionsListMessage "Select which task to perform" \
        ""\
        "$(cat << EOF 
1. $copy_create_folder
2. $create_new_folder
EOF
        )"

        option=$(optionSelector "[1/2]")
        case $( echo "$option" | xargs ) in
            "1")
               terminalMessage select "$copy_create_folder"

                # get core values
                IFS="," read -r folder_name number_of_command numbering_position start_numbering_from <<< "$( getFileFldCreationInput "folder" )"
                # user commands
                getCommandPreviewForFilesFld "folder" "$folder_name" "$number_of_command" "$numbering_position" "$start_numbering_from"      
                askToContinue

                ;;
            "2")
                terminalMessage select "$create_new_folder"
                # get core values
                IFS="," read -r folder_name number_of_command numbering_position start_numbering_from <<< "$( getFileFldCreationInput "folder" )"
                # user commands
                getCommandPreviewForFilesFld "folder" "$folder_name" "$number_of_command" "$numbering_position" "$start_numbering_from"        
                askToContinue
                createFolders "$folder_name" "$number_of_command" "$numbering_position" "$start_numbering_from"
                    
                [[ $? == 1 ]] && exit 1
                ;;
            *)
                terminalMessage invalid "Please Choose a correct one"
                exit 1
                ;;

        esac
        ;;
    *)
        terminalMessage invalid "Please Choose a correct one"
        exit 1
        ;;
esac





