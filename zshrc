# === Oh My Zsh Setup ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# === Homebrew Setup ===
export HOMEBREW_NO_ANALYTICS=1
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  [[ -d /opt/homebrew/bin ]] && path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
fi
typeset -U path PATH

# === GPG Agent Configuration ===
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -q '^default-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -q '^max-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf

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
# Kubernetes
export KUBECONFIG="$HOME/.kube/config"

# === Aliases ===
source $HOME/.aliases  
