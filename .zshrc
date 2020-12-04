GOPATH=~/go

_path+="$HOME/.bin"
_path+=":$HOME/.local/bin"
_path+=":$HOME/.tgenv/bin"
_path+=":$GOPATH/bin"
_path+=":$HOME/.krew/bin"

PATH="$_path:$PATH"
source "$HOME/.zshrc.secret" # keep private things in a separate file

TERM="xterm-256color"

# --------------------------------------------------------------------------
# zsh related
# --------------------------------------------------------------------------
# Path to oh-my-zsh installation
ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(
    ssh-agent
    zsh-autosuggestions
    zsh-syntax-highlighting # has to be the last plugin
)

# --------------------------------------------------------------------------
# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS

source $ZSH/oh-my-zsh.sh
[ -f $HOME/.helm/helmenv.sh ] && source $HOME/.helm/helmenv.sh

# keep secrets secret ;)
[ -f $HOME/.zshrc.secret ] && source $HOME/.zshrc.secret

# --------------------------------------------------------------------------
# direnv
if command -v direnv &>/dev/null; then
    export DIRENV_WARN_TIMEOUT=120s
    eval "$(direnv hook zsh)"
fi

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
alias kalias='alias | egrep "kx=|kn=|kc=|kgi=|kgp=|kgs=|kctx0|kcon=|kgc="'

# eval "$(eksctl completion zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
