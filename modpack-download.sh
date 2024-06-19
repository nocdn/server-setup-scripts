#!/bin/bash

# Function to prompt for user input and validate the response
get_user_input() {
    local prompt=$1
    local max_val=$2
    local input

    while true; do
        read -p "$prompt" input
        if [[ $input =~ ^[0-9]+$ ]] && (( input >= 1 && input <= max_val )); then
            echo $input
            return
        else
            echo "Invalid selection. Please enter a number between 1 and $max_val."
        fi
    done
}

clear
echo -n "Enter the modpack to find: "
read searchQuery

formattedSearchQuery=$(echo $searchQuery | sed 's/ /+/g')

response=$(curl -s "https://www.curseforge.com/api/v1/mods/search?gameId=432&index=0&classId=4471&filterText=$formattedSearchQuery&pageSize=20&sortField=2")
responseJson=$(echo $response | jq '.data')

clear
if [ $(echo $responseJson | jq 'length') -gt 0 ]; then
    for i in $(seq 0 $(($(echo $responseJson | jq 'length') - 1))); do
        modpack_name=$(echo $responseJson | jq -r ".[$i].name")
        echo "$((i + 1)). $modpack_name"
    done

    choice=$(get_user_input "Enter the number of the modpack you want to see the ID for: " $(echo $responseJson | jq 'length'))

    selected_modpack=$(echo $responseJson | jq ".[$((choice - 1))]")
    modpack_id=$(echo $selected_modpack | jq -r '.id')
    clear
    echo "Modpack ID: $modpack_id"

    filesResponse=$(curl -s "https://www.curseforge.com/api/v1/mods/$modpack_id/files")
    filesResponseJson=$(echo $filesResponse | jq '.data')

    clear
    for i in $(seq 0 $(($(echo $filesResponseJson | jq 'length') - 1))); do
        file_name=$(echo $filesResponseJson | jq -r ".[$i].displayName")
        echo "$((i + 1)). $file_name"
    done

    fileChoice=$(get_user_input "Enter the number of the file you want to see the ID for: " $(echo $filesResponseJson | jq 'length'))

    selected_file=$(echo $filesResponseJson | jq ".[$((fileChoice - 1))]")
    file_id=$(echo $selected_file | jq -r '.id')
    clear
    echo "File ID: $file_id"

    additionalFilesResponse=$(curl -s "https://www.curseforge.com/api/v1/mods/$modpack_id/files/$file_id/additional-files")
    additionalFilesResponseJson=$(echo $additionalFilesResponse | jq '.data')

    clear
    for i in $(seq 0 $(($(echo $additionalFilesResponseJson | jq 'length') - 1))); do
        additional_file_name=$(echo $additionalFilesResponseJson | jq -r ".[$i].displayName")
        echo "$((i + 1)). $additional_file_name"
    done

    additionalFileChoice=$(get_user_input "Enter the number of the additional file you want to see the ID for: " $(echo $additionalFilesResponseJson | jq 'length'))

    selected_additional_file=$(echo $additionalFilesResponseJson | jq ".[$((additionalFileChoice - 1))]")
    additional_file_id=$(echo $selected_additional_file | jq -r '.id')
    additional_file_name=$(echo $selected_additional_file | jq -r '.fileName')
    clear
    echo "Additional File ID: $additional_file_id"

    curl -O "https://mediafilez.forgecdn.net/files/${additional_file_id:0:4}/${additional_file_id: -3}/$additional_file_name"
else
    echo "No modpacks found."
fi
