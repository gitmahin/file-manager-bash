# !/bin/bash

terminalMessage(){
    type=$1
    case "$type" in
        "select")
            type="SELECTED"
            ;;
        "invalid")
            type="INVALID"
            ;;
        "error")
            type="ERROR"
            ;;
        *)
            type="UNDEFINED"
            ;;
    esac

    cat << EOF 

**********************************
$type
$2
**********************************
EOF
}

optionsListMessage() {
    title=$1
    desc=$2
    options=$3
    cat << EOF
$title
$desc
$options
EOF
}

getCommandPreviewForFilesFld() {
    type=$1
    name=$2
    number_of_command=$3
    numbering_position=$4
    start_numbering_from=$5
cat << EOF
Your Command:

1. Given $type name: ${name:-"Undefined"}
   $( [[ -z "$name" ]] && echo "!!!An undefined $type cannot be created, and this operation will lead to an error!!!" ) 
2. Number of ${type}s creation: ${number_of_command:-"DEFAULT - 1"}
3. Numbering position: ${numbering_position:-"DEFAULT - Right"}
4. Starting from: ${start_numbering_from:-"DEFAULT - 1"}
EOF
}

askToContinue() {
    local option message=${1:-"Continue?"} fallbackOption=${2:-"y"}
    read -p "$message - [y/n]: " option
    # fallback y given so that if user dont enter anything the default value should be yes
    [[ "${option:-$fallbackOption}" != "y" ]] && exit 1
}

optionSelector() {
    options=$1
    read -p "Choose - $options: " option
    echo "$option"
}

getFileFldCreationInput() {
    
    local type=$1 name number_of_command numbering_position start_numbering_from
    read -p "Enter the $type name: " name
    read -p "How many ${type}s do you want to create?. (Should be positive integer): " number_of_command
    read -p "Set the numbering position: [L/R] " numbering_position
    read -p "Starting from: [number] " start_numbering_from

    # to use with read make one line string. you can use readarray and make each echo on new line.
    echo "$name,$number_of_command,$numbering_position,$start_numbering_from"
   
}

modifyFileFldCopyCreationInput() {
    local type=$1 output_name

    askToContinue "Want to modify default settings?" "n"
    read -p "Output $type name: " output_name 
    echo "$output_name"
}

getModifyDefaultCommandPreview(){
local type=$1 name$2
cat << EOF

More:
1. Output $type name: ${name:-"DEFAULT"}
EOF
}