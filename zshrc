# === Oh My Zsh Setup ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Always-on plugins, plus optional ones only when installed (CERN has only git)
plugins=(git)
for _p in zsh-syntax-highlighting zsh-autosuggestions zsh-completions; do
  [[ -d "$ZSH/custom/plugins/$_p" ]] && plugins+=("$_p")
done
unset _p

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# === Host indicator (distinguish CERN hosts with different permissions) ===
case "${HOST%%.*}" in
  aiadm*)  _host_color=red ;;
  ciadm*)  _host_color=yellow ;;
  lxplus*) _host_color=cyan ;;
  *)       _host_color="" ;;
esac
if [ -n "$_host_color" ]; then
  PROMPT="%{$fg_bold[$_host_color]%}[%m]%{$reset_color%} $PROMPT"
fi
unset _host_color

# Accept autosuggestion on Shift+Tab (only when the plugin is loaded)
if [[ " ${plugins[*]} " == *" zsh-autosuggestions "* ]]; then
  bindkey -M emacs '^[[Z' autosuggest-accept
  bindkey -M viins '^[[Z' autosuggest-accept
  bindkey '^[[Z' autosuggest-accept
fi

# === GPG Agent Configuration ===
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -q '^default-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -q '^max-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf

# === SSH Agent ===
# No-ops on CERN where a forwarded agent already provides SSH_AUTH_SOCK
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
fi

# === macOS-only ===
if [[ "$OSTYPE" == darwin* ]]; then
  export PYTHONPATH="/Users/barnes-c/Code/cern/python-landb-rest-client:$PYTHONPATH"

  # Homebrew
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_UPGRADE_QUIT_CASKS=1
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # OpenSSL (prepend so it takes priority)
  export PATH="/opt/homebrew/opt/openssl/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/openssl/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig"

  # VS Code
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  # Python
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$HOME/Library/Python/3.9/bin:$PATH"

  # noTunes
  defaults write digital.twisted.noTunes replacement /Applications/Spotify.app

  # bun
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

  # pipx
  export PATH="$PATH:$HOME/.local/bin"

  # nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# === CERN/Linux-only ===
if [[ "$OSTYPE" == linux* ]]; then
  # AFS bin
  export PATH=$PATH:/afs/cern.ch/user/c/chbarnes/bin
fi

# === Common ===
export PATH="$HOME/bin:$PATH"
typeset -U path PATH

# Go
export GOPATH=$(go env GOPATH 2>/dev/null || echo "$HOME/go")
export PATH=$PATH:$GOPATH/bin
# Kubernetes
export KUBECONFIG="$HOME/.kube/config"
# Anthropic
export ANTHROPIC_TELEMETRY=0

# === Aliases ===
source $HOME/.aliases
