# !/bin/bash

examples="other-examples"
example_npm="example-npm"
example_zenity="example-zenity"

example_files=("$example_npm" "$example_zenity")

askToContinue() {
    read -p "$1 $2": options
    [[ "$options" != [yY] ]] && return 1
    return 0
}

for (( i=0; i < "${#example_files[@]}"; i++ )); do
    [[ ! -d "$examples" ]] && { echo "[$examples] folder not exist!"; }
    [[ ! -d "$examples/${example_files["$i"]}" ]] && { echo "[${example_files["$i"]}] folder not exist"; mkdir -p "$examples/${example_files["$i"]}/src/tests" ; }
done

# EXAMPLE WITH NPM
if [[ -d "$examples/$example_npm" ]]; then
   
    cp "src/constants.sh" "$examples/$example_npm/src/"
    cp "src/utils.sh" "$examples/$example_npm/src/"
    cp "src/lib.sh" "$examples/$example_npm/src/"
    cp "src/filemanager.sh" "$examples/$example_npm/src/"

    cp "test.sh" "$examples/$example_npm/"
    cp "src/tests/"*.bats "$examples/$example_npm/src/tests/"

    echo "File copied to $examples/$example_npm success"
    
fi

# EXAMPLE WITH ZENITY
if [[ -d "$examples/$example_zenity" ]]; then
   
    cp "src/lib.sh" "$examples/$example_zenity/src/"

    cp -r "src/tests" "$examples/$example_zenity/src/"
    cp "test.sh" "$examples/$example_zenity/"

    cp "install.sh" "$examples/$example_zenity/"

    cp ".gitmodules" "$examples/$example_zenity/"

    echo "File copied to $examples/$example_zenity success"
 
fi