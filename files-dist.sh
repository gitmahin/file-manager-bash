# !/bin/bash

examples="other-examples"
example_npm="example-npm"
example_zenity="example-zenity"
example_files=("$example_npm" "$example_zenity")

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
    cp "start.sh" "$examples/$example_npm/"
    cp "src/tests/"*.bats "$examples/$example_npm/src/tests/"

    echo "File copied to $examples/$example_npm success"
    
fi

# EXAMPLE WITH ZENITY
if [[ -d "$examples/$example_zenity" ]]; then
   
    cp "src/lib.sh" "$examples/$example_zenity/src/"

    cp -r "src/tests" "$examples/$example_zenity/src/"
    cp "test.sh" "$examples/$example_zenity/"

    cp "install.dev.sh" "$examples/$example_zenity/"
    cp "start.sh" "$examples/$example_zenity/"

    cp ".gitmodules" "$examples/$example_zenity/"

    recommended_files=("utils.sh" "constants.sh")

    for (( i=0; i < "${#recommended_files[@]}"; i++ )); do
        [[ ! -e "$examples/$example_zenity/src/${recommended_files["$i"]}" ]] && (touch "$examples/$example_zenity/src/${recommended_files["$i"]}")
        echo "${recommended_files["$i"]} files created for zenity"
    done

    echo "File copied to $examples/$example_zenity success"
 
fi