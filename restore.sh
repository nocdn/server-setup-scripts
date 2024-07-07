#!/bin/bash

# Bucket name
bucket="modded-server-backups"

echo "Fetching list of files from S3 bucket: $bucket..."

# Get list of files sorted by last modified date (newest first)
files=$(aws s3 ls s3://$bucket/ --recursive | sort -r | awk '{print $4}')

if [ -z "$files" ]; then
    echo "No files found in the bucket."
    exit 1
fi

# Display files with an index number
echo -e "Files in the bucket:\n"
index=1
for file in $files; do
    echo "[$index]: $file"
    index=$((index+1))
done

# Ask user to select a file to download
echo -e "\nEnter number of file to download: "
read file_number

# Validate input
re='^[0-9]+$'
if ! [[ $file_number =~ $re ]] ; then
   echo "Error: Not a number" >&2; exit 1
fi

# Convert input number to array index
array_index=$((file_number-1))

# Get filename from index
file_names=($files)
selected_file=${file_names[$array_index]}

if [ -z "$selected_file" ]; then
    echo "Invalid file number selected."
    exit 1
else
    echo "You selected: $selected_file"
fi

# Download the selected file
echo "Downloading $selected_file..."
s5cmd cp s3://$bucket/$selected_file ./

echo "$selected_file has been downloaded successfully."