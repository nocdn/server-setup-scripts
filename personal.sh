apt update

# install eza
apt install -y gpg
mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
apt update
apt install -y eza

export PATH=$PATH:/root/.local/bin

# install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo "eval \"\$(zoxide init bash)\"" >> ~/.bashrc

# Add aliases to the end of the user's .bashrc file
echo "" >> ~/.bashrc
echo "# Custom aliases" >> ~/.bashrc
echo "alias bashconfig=\"code ~/.bashrc\"" >> ~/.bashrc
echo "alias reload=\"source ~/.bashrc\"" >> ~/.bashrc
echo "alias la=\"eza -l --no-permissions --no-user -a --group-directories-first\"" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc
echo "alias ga='git add'" >> ~/.bashrc
echo "alias gp='git push'" >> ~/.bashrc
echo "alias gc='git commit'" >> ~/.bashrc
echo "alias cp='cp -iv'" >> ~/.bashrc
echo "alias mv='mv -iv'" >> ~/.bashrc
echo "alias cl='clear'" >> ~/.bashrc
echo "alias ipinfo='curl -s http://ip-api.com/json/ | jq \"" >> ~/.bashrc

# Bind keys for history search (eg. only show matches from the current line)
autoload -Uz compinit && compinit
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

eval "$(zoxide init --cmd cd zsh)"

# reload the .bashrc file
source ~/.bashrc

# Make Bash completion case-insensitive
bind "set completion-ignore-case on"

# Disable menu completion if it has been enabled
bind 'set show-all-if-ambiguous off'
bind 'set menu-complete off'


# Set the history file
HISTFILE=~/.bash_history

# Set the maximum number of history entries
HISTSIZE=10000
HISTFILESIZE=10000

# Control history duplicates and append behavior
HISTCONTROL=ignoreboth  # equivalent to hist_ignore_dups and hist_ignore_all_dups
shopt -s histappend     # equivalent to appendhistory

# Ensure history is shared between terminals
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

source ~/.bashrc

apt upgrade -y