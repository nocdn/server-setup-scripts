# server-setup-scripts

For a personal setup script, first make sure you know the root password, or reset it with this:

```bash
sudo passwd root
sudo passwd bartek
```

Then setup zsh this:

```bash
sudo apt update && sudo apt upgrade -y && sudo apt -y install zsh nano curl && chsh -s $(which zsh)
```

Then restart the terminal (or close SSH connection to start a new one)
Choose option 0 to create a new .zshrc file

Then run the script below after downloading it with the command:

```bash
curl -O "https://raw.githubusercontent.com/Kayetic/Server-Setup-Scripts/main/setup.sh" && chmod +x ./setup.sh && ./setup.sh && rm ./setup.sh
```

To download the modpack script, run the following command:

```bash
curl -O "https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/minecraft-general.sh" && chmod +x minecraft-general.sh && sudo bash minecraft-general.sh && rm minecraft-general.sh
```

(This will download the script, make it executable, run it, and then delete it when it finishes.)

To add a wsl symlink when using WSL2, run the following command:

```bash
curl -O "https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/wsl-symlink.sh" && chmod +x wsl-symlink.sh && ./wsl-symlink.sh && rm wsl-symlink.sh
```
