# === Oh My Zsh Setup ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# === Node Version Manager (NVM) Setup ===
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"

# === GPG Agent Configuration ===
echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf

# === PATH and Compiler Flags ===
# Prepend Python and OpenSSL paths so they take priority.
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig"
# Append VS Code and Go paths.
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
# YubiKey
export SSH_AUTH_SOCK="$(brew --prefix)/var/run/yubikey-agent.sock"


# === Aliases ===
source $HOME/Code/dotfiles/shell/.aliases  

# === Auto completes ===
autoload -U +X bashcompinit && bashcompinit
autoload -U compinit && compinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
