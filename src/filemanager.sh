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
        read -p "Choose - [1/2]: " option
        
        number_of_command=1
        numbering_position="r"
        case $(echo "$option" | xargs) in
            "1")
                # COPY AND CREATE FILES
                # get core values 
                read -p "Enter the file name (include file ext): " file_name 
                read -p "How many files do you want to create? (Should be positive integer): " number_of_command

                # asking modify output file name
                read -p "Want to modify default settings? - [y/n]: " option
                [[ "${option:-"n"}" == "y" ]] && read -p "Output file name: " output_file_name 

                # user commands
                optionsListMessage "Your Command:" \
                "" \
                "$(
                cat << EOF
1. Given file name: $file_name
2. Output file name: ${output_file_name:-"DEFAULT"}
3. Number of files creation: $number_of_command
EOF
                )"

                askToContinue

                copyNCreateFiles "$file_name" "$output_file_name" "$number_of_command"
                
                [[ $? == 1 ]] && exit 1
                ;;
            "2")
                # FILES CREATION
                read -p "Enter the file name: " file_name
                read -p "How many files do you want to create? (Should be positive integer): " number_of_command
               
                # user commands
                optionsListMessage "Your Command:" \
                "" \
                "$(
                cat << EOF
1. Given file name: $file_name
2. Number of files creation: $number_of_command
EOF
                )"

                askToContinue
                createFiles "$file_name" "$number_of_command"
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
        read -p "Enter the folder name:" folder_name
        read -p "How many folders do you want to create?. (Should be positive integer): " number_of_command
        read -p "Set the numbering position: [L/R]" numbering_position

                        # message
                optionsListMessage "Your Command:" \
                "" \
                "$(
                cat << EOF
1. Given folder name: $folder_name
2. Numbering position:" $numbering_position
3. Number of folder creation: $number_of_command
EOF
                )"

        askToContinue

        createFolders "$folder_name" "$number_of_command" "$numbering_position"

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





