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

# === GPG Agent Configuration ===
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -q '^default-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -q '^max-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf

# Go
export GOPATH=$(go env GOPATH 2>/dev/null || echo "$HOME/go")
export PATH=$PATH:$GOPATH/bin
# Kubernetes
export KUBECONFIG="$HOME/.kube/config"
# Kerberos
export KRB5_CONFIG="$HOME/krb5.conf"
export KRB5CCNAME="FILE:/run/user/180653/krb5cc"

# === Aliases ===
source $HOME/.aliases

# bun completions
[ -s "/Users/barnes-c/.bun/_bun" ] && source "/Users/barnes-c/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/bin:$PATH"
