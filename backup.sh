#!/bin/bash

# Define the source directory and S3 bucket path
source_directory="/home/nk3h8wbq/server-files/simplebackups/"
s3_bucket="s3://modded-server-backups/"

# Upload all files from the source directory to the S3 bucket
s5cmd cp "${source_directory}" "${s3_bucket}" --recursive

if [ $? -eq 0 ]; then
    echo "Successfully uploaded all files from ${source_directory} to S3 bucket 'modded-server-backups'."

    # Remove all files from the source directory after successful upload
    rm -rf "${source_directory}"*
    if [ $? -eq 0 ]; then
        echo "Successfully deleted all files from ${source_directory}."
    else
        echo "Failed to delete files from ${source_directory}."
    fi
else
    echo "Failed to upload files from ${source_directory} to S3 bucket 'modded-server-backups'."
fi