# !/bin/bash

START_SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "$START_SCRIPT_DIR/utils.sh"

copyNCreateFiles() {
    file_name="$1"
    number_of_command="${2:-1}"
    numbering_position="${3:-r}"
    start_numbering_from="${4:-2}"
    output_file_name="$5"

    # getting full path of the file to avoid errors 
    echo "Searching... [$file_name]"
    file_location=$(find / -iname "$file_name" 2>/dev/null | head -n 1)

    [[ ! -e "$file_location" ]] && { echo "File not found in this system"; return 1; }

    real_file=$(basename "$file_location")

    IFS="." read -r extracted_file_name file_ext <<< "${output_file_name:-"$real_file"}"
    for (( i=0; i < "$number_of_command"; i++ )); do
            # fallback output_file_name

            if [[ "$numbering_position" == [lL] ]]; then
                dest_file="$((i+start_numbering_from))-$extracted_file_name.$file_ext"
            elif [[ "$numbering_position" == [rR] ]]; then
                dest_file="$extracted_file_name-$((i+start_numbering_from)).$file_ext"
            else
                echo "Invalid request!"
                return 1
            fi

            cp "$file_location" "$dest_file"
            echo "Copied & Created: $dest_file"
            [[ ! -e "$dest_file" ]] && { echo "Failed to create - $dest_file"; return 1; }
    done
    echo "done"
    return 0
}

createFiles(){
    file_name="$1"
    number_of_command="${2:-1}"
    numbering_position="${3:-r}"
    start_numbering_from="${4:-1}"

    [[ -z "$file_name" ]] && { echo "File name cannot be undefined"; return 1; }

    IFS="." read -r extracted_file_name file_ext <<< "$file_name"
    for (( i=0; i < "$number_of_command"; i++ )); do


        if [[ "$numbering_position" == [lL] ]]; then
            new_file="$((i+start_numbering_from))-$extracted_file_name.$file_ext"
        elif [[ "$numbering_position" == [rR] ]]; then
            new_file="$extracted_file_name-$((i+start_numbering_from)).$file_ext"
        else
            echo "Invalid request!"
            return 1
        fi

        touch "$new_file"
        echo "Created: $new_file"
        [[ ! -e "$new_file" ]] && { echo "Failed to create - $new_file"; return 1; }

    done
    echo "done"
    return 0
}

createFolders() {
    folder_name="$1"
    number_of_command="${2:-1}"
    numbering_position="${3:-r}"
    start_numbering_from="${4:-1}"

    [[ -z "$folder_name" ]] && { echo "Folder name cannot be undefined"; return 1; }

    for (( i=0; i < "$number_of_command"; i++ )); do

        new_folder="$(getFolderWithNumberingPosition "$folder_name" "$numbering_position")"

        [[ $? == 1 ]] && return 1

        mkdir "$new_folder"
        echo "Created: $new_folder"
        [[ ! -d "$new_folder" ]] && { echo "Failed to create - $new_folder"; return 1; }

    done
    echo "done"
    return 0
}

copyNCreateFolders() {
    folder_name="$1"
    number_of_command="${2:-1}"
    numbering_position="${3:-r}"
    start_numbering_from="${4:-2}"
    output_folder_name="$5"

    [[ ! -d "$folder_name" ]] && { echo "Cannot find your folder"; return 1; }

    for (( i=0; i<number_of_command; i++ )); do
        new_folder="$(getFolderWithNumberingPosition "${output_folder_name:-"$folder_name"}" "$numbering_position")"
        [[ $? == 1 ]] && return 1

        cp -r "$folder_name" "$new_folder"
        echo "Copied & Created: $new_folder"

        [[ ! -d "$new_folder" ]] && { echo "Failed to copy & create- $new_folder"; return 1; }
    done
    echo "done"
    return 0
}