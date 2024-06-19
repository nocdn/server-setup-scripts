sudo apt update
sudo apt upgrade -y

sudo apt install -y nano wget curl zip neofetch python3 pgp gawk make fzf git awscli jq

rm ~/.zshrc
curl -O "https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/.zshrc"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-syntax-highlighting/Raspbian_9.0/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-syntax-highlighting.list
curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/Raspbian_9.0/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-syntax-highlighting.gpg > /dev/null
sudo apt update
sudo apt install zsh-syntax-highlighting

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

USER_HOME=$(eval echo ~"$USER")
LOCAL_BIN_PATH="$USER_HOME/.local/bin"
CONFIG_FILE="$USER_HOME/.zshrc"

echo "" >> "$CONFIG_FILE"
echo "export PATH=\"\$PATH:$LOCAL_BIN_PATH\"" >> "$CONFIG_FILE"
echo "Added $LOCAL_BIN_PATH to $CONFIG_FILE"

echo "" >> "$CONFIG_FILE"
echo "eval \"\$(zoxide init --cmd cd zsh)\"" >> "$CONFIG_FILE"
echo "Added zoxide init to $CONFIG_FILE"

git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cd zsh-syntax-highlighting/themes/
cp -v catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
echo "" >> ${ZDOTDIR:-$HOME}/.zshrc
echo "source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
