# Server-Setup-Scripts

For a personal setup script, first download and setup zsh this:

```bash
sudo apt update && sudo apt upgrade -y && sudo apt -y install zsh nano && chsh -s $(which zsh)
```

Then restart the terminal (or close SSH connection to start a new one)
Choose option 0 to create a new .zshrc file

Then run the script below after downloading it with the command:

```bash
curl -O "https://raw.githubusercontent.com/Kayetic/Server-Setup-Scripts/main/setup.sh" && chmod +x ./setup.sh
```

To download the modpack script, run the following command:

```bash
curl -O "https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/minecraft-general.sh" && chmod +x general.sh && sudo bash general.sh && rm general.sh
```

(This will download the script, make it executable, run it, and then delete it when it finishes.)
