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

askToContinue() {
    read -p "Continue? - [y/n]: " option
    [[ "${option:-"y"}" != "y" ]] && exit 1
}
