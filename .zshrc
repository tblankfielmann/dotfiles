GOPATH=$HOME
SOURCE=$GOPATH/src

_path+="$HOME/.bin"
_path+=":$HOME/.local/bin"
_path+=":$HOME/.tgenv/bin"
_path+=":$HOME/.helmenv/bin"
_path+=":$GOPATH/bin"
_path+=":$HOME/.krew/bin"
_path+=":$HOME/.cargo/bin"

PATH="$_path:$PATH"
TERM="xterm-256color"

ssh-add -K ~/.ssh/id_rsa # macOS: passphrase will also be stored in the user's keychain

# --------------------------------------------------------------------------
# zsh related
# --------------------------------------------------------------------------
# Path to oh-my-zsh installation
ZSH="$HOME/.oh-my-zsh"
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
HISTCONTROL=ignoredups:ignorespace
source "$ZSH/oh-my-zsh.sh"

plugins=(
    terraform
    kubectl
    zsh-autosuggestions
    zsh-syntax-highlighting
)
# zsh-syntax-highlighting  has to be the last plugin

# --------------------------------------------------------------------------
# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS

# --------------------------------------------------------------------------
# helmenv
[ -e $HOME/.helm/helmenv.sh ] && source $HOME/.helm/helmenv.sh

# --------------------------------------------------------------------------
# keep secrets secret ;)
[ -e $HOME/.zshrc.secret ] && source $HOME/.zshrc.secret

# iTerm2
[ -e "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# --------------------------------------------------------------------------
# direnv
if command -v direnv &>/dev/null; then
    export DIRENV_WARN_TIMEOUT=120s
    eval "$(direnv hook zsh)"
fi

# eksctl
# eval "$(eksctl completion zsh)"

# --------------------------------------------------------------------------
# Preferred editor for local and remote sessions
if [ -n "$SSH_CONNECTION" ]; then
    export EDITOR='vim'
else
    export EDITOR='code'
fi

# --------------------------------------------------------------------------
# edit ~/.zshrc
alias ec="$EDITOR $HOME/.zshrc"
# source ~/.zshrc
alias sc="source $HOME/.zshrc"
# edit ~/.Brewfile
alias eb="$EDITOR $HOME/.Brewfile"

alias git-open='gh repo view --web'
alias mtr='sudo /usr/local/sbin/mtr'

# prune docker files
alias docker-prune='docker system prune --all --force --volumes'

alias pre-commit-show='pre-commit run --all-files --show-diff-on-failure'

# alias tf='terraform'

# --------------------------------------------------------------------------
# Kubernetes
export KUBERNETES_MASTER=""
export KUBE_EDITOR='code --wait'
# see https://github.com/ahmetb/kubectl-aliases
alias kx="kubectx"
alias kn="kubens"
alias kc='kubectl'
# alias kgi='kubectl cluster-info'
# alias kgp='kubectl get pods'
# alias kgs='kubectl get svc'
# alias kgc='kubectl get componentstatuses'
# alias kctx='kubectl config current-context'
# alias kcon='kubectl config use-context'
# alias kgc='kubectl config get-context'
alias kalias='alias | egrep "kx=|kn=|kc=|kgi=|kgp=|kgs=|kct|kcon=|kgc="'
