#!/bin/bash

# update sudo:
sudo apt update -y
sudo apt upgrade -y

# installing adoptium jre
curl -O "https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/install-adoptium-jre.sh"
sudo ./install-adoptium-jre.sh

# configure aws cli:
aws configure

# download the backup and restore scripts:

# getting the user's home directory to save into:
HOME_DIR=$(eval echo ~${SUDO_USER})
USER_NAME=${SUDO_USER:-$USER}

curl -o "backup.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/backup.sh
curl -o "secondaryBackup.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/secondaryBackup.sh
curl -o "restore.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/restore.sh
curl -o "modpack-download.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/modpack-download.sh
chmod +x "backup.sh"
chmod +x "secondaryBackup.sh"
chmod +x "restore.sh"
chmod +x "modpack-download.sh"

echo "Java version:"
java --version