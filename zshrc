# === Oh My Zsh Setup ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
 git
 zsh-syntax-highlighting
 zsh-autosuggestions
 zsh-completions
)

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Accept autosuggestion on Shift+Tab
bindkey -M emacs '^[[Z' autosuggest-accept
bindkey -M viins '^[[Z' autosuggest-accept
bindkey '^[[Z' autosuggest-accept

# === Homebrew Setup ===
export HOMEBREW_NO_ANALYTICS=1
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
typeset -U path PATH

# === GPG Agent Configuration ===
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -q '^default-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -q '^max-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf

# === PATH and Compiler Flags ===
# Prepend OpenSSL paths so they take priority
export PATH="/opt/homebrew/opt/openssl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig"
# VS Code
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# Python
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
# Go
export GOPATH=$(go env GOPATH 2>/dev/null || echo "$HOME/go")
export PATH=$PATH:$GOPATH/bin
# Kubernetes
export KUBECONFIG="$HOME/.kube/config"

# === nTunes Setup ===
defaults write digital.twisted.noTunes replacement /Applications/Spotify.app

# === Aliases ===
source $HOME/.aliases

# bun completions
[ -s "/Users/barnes-c/.bun/_bun" ] && source "/Users/barnes-c/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/bin:$PATH"
