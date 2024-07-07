#!/bin/bash

# Get current date and time in DD-MM-YYYY-HH-MM-SS format
current_datetime=$(date +%d-%m-%Y-%H-%M-%S)

# Define the directory to zip
directory_to_zip="server-files/"

# Create the filename with the current date and time
zip_filename="full-backup-${current_datetime}.zip"

# Running the zip command with the generated filename
zip -r "${zip_filename}" "${directory_to_zip}"

echo "Files have been zipped into ${zip_filename}"

# Upload the zip file to the S3 bucket
s5cmd cp "${zip_filename}" "s3://modded-server-backups/${zip_filename}"

if [ $? -eq 0 ]; then
    echo "Successfully uploaded ${zip_filename} to S3 bucket 'modded-server-backups'."
else
    echo "Failed to upload ${zip_filename} to S3 bucket 'modded-server-backups'."
fi

sleep 2

# Remove the zip file after upload
rm "$zip_filename"