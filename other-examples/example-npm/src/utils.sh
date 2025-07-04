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
    name=$1
    type=$2
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
    read -p "Continue? - [y/n]: " option
    [[ "${option:-"y"}" != "y" ]] && exit 1
}

optionSelector() {
    options=$1
    read -p "Choose - $options: " option
    echo "$option"
}