# === Oh My Zsh Setup ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# === GPG Agent Configuration ===
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -q '^default-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -q '^max-cache-ttl ' ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf

# === Exports ===
# Kubernetes
export KUBECONFIG="$HOME/.kube/config"
# Kerberos
export KRB5_CONFIG="~/krb5.conf"
export KRB5CCNAME="FILE:/run/user/180653/krb5cc"

# === Aliases ===
source $HOME/.aliases  
