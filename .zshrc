# ============= START UTIL ALIAS STUFF

# Navigating to project folder
alias unii="cd $HOME/code/uniswap/interface"

# Git related aliases
gitfetch() {
  git fetch --all
  git checkout $1
  git rebase
}
alias main="gitfetch main"
alias master="gitfetch master"

# System utility aliases
alias macspoof="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' | xargs sudo ifconfig en0 ether"
alias lostmybranch="git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:relative)'"

# ============= START CONFIG

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add custom zsh functions to fpath
fpath=($fpath "$HOME/.zfunctions")

# Spaceship ZSH prompt setup
autoload -U promptinit; promptinit
prompt spaceship

# nvmrc handling
autoload -U add-zsh-hook
load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Syntax highlighting
source /usr/local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Nix installer
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi

# Environment variable exports
export PNPM_HOME="$HOME/Library/pnpm"
export GEM_HOME=$HOME/.gem
export PATH="$GEM_HOME:$PNPM_HOME:$PATH"
export USE_FLIPPER=1
export PATH="$PATH:$HOME/.foundry/bin"

# rbenv initialization
eval "$(rbenv init - zsh)"
