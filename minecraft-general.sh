#!/bin/bash

# update sudo:
sudo apt update -y
sudo apt upgrade -y

# installing adoptium jre
curl -O "https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/install-adoptium-jre.sh"

# Check if the script was downloaded
if [ -f "./install-adoptium-jre.sh" ]; then
    chmod +x ./install-adoptium-jre.sh
    sudo ./install-adoptium-jre.sh
else
    echo "Failed to download install-adoptium-jre.sh"
    exit 1
fi

# configure aws cli:
aws configure

# installing s5cmd

echo 'Installing s5cmd'
go install github.com/peak/s5cmd/v2@master

# getting the user's home directory to save into:
HOME_DIR=$(eval echo ~${SUDO_USER})
USER_NAME=${SUDO_USER:-$USER}

curl -o "${HOME_DIR}/backup.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/backup.sh
curl -o "${HOME_DIR}/secondaryBackup.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/secondaryBackup.sh
curl -o "${HOME_DIR}/restore.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/restore.sh
curl -o "${HOME_DIR}/modpack-download.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/modpack-download.sh
chmod +x "${HOME_DIR}/backup.sh"
chmod +x "${HOME_DIR}/secondaryBackup.sh"
chmod +x "${HOME_DIR}/restore.sh"
chmod +x "${HOME_DIR}/modpack-download.sh"

echo "Java version:"
java --version