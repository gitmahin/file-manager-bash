# !/bin/bash

# can create bulk serial files and folders 1, 2, 3
# can create multiple files and folders
# can zip unzip files and folders

source "$START_SCRIPT_DIR/src/lib.sh"
source "$START_SCRIPT_DIR/src/utils.sh"

documents_path=$(xdg-user-dir DOCUMENTS 2>/dev/null)

[[ ! -d  "$documents_path" ]] && documents_path="$HOME/Documents"

mkdir -p "$documents_path/filemanager"
echo "Initialized filemanager path for $documents_path"

option=""

cat << EOF
***********************************
====Welcome To The Filemanager=====
***********************************
Select a task to perform.
1. Create files in bulk serially
2. Create folders in bulk serially
3. Zip manager
EOF

read -p "Choose a task - [1/2/3]: " option

case $(echo "$option" | xargs) in
    "1")
        # selected message
        terminalMessage select "Create files in bulk serially"
        # choose options
        optionsListMessage "Select which task to perform" \
        ""\
        "$(cat << EOF 
1. Copy and Create
2. Create new
EOF
        )"

        option=$(optionSelector "[1/2]")
        case $(echo "$option" | xargs) in
            "1")
                # COPY AND CREATE FILES
                # get core values 

                IFS="," read -r file_name number_of_command numbering_position start_numbering_from <<< "$( getFileFldCreationInput "file" )"
                IFS="," read -r output_file_name <<< "$( modifyFileFldCopyCreationInput "file" )"

                # user commands
                getCommandPreviewForFilesFld "file" "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from"
                getModifyDefaultCommandPreview "file" "$output_file_name"
                askToContinue
                copyNCreateFiles "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from" "$output_file_name"
                
                [[ $? == 1 ]] && exit 1
                ;;
            "2")
                # FILES CREATION
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
        terminalMessage select "Create folders in bulk serially"
        # get core values
        IFS="," read -r folder_name number_of_command numbering_position start_numbering_from <<< "$( getFileFldCreationInput "folder" )"
        # user commands
        getCommandPreviewForFilesFld "folder" "$folder_name" "$number_of_command" "$numbering_position" "$start_numbering_from"        
        askToContinue
        createFolders "$folder_name" "$number_of_command" "$numbering_position" "$start_numbering_from"

        [[ $? == 1 ]] && exit 1
        ;;
    "3")
        terminalMessage select "Create folders in bulk serially"
        ;;
    *)
        terminalMessage invalid "Please Choose a correct one"
        exit 1
        ;;
esac





