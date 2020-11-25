GOPATH=~/go

_path+="$HOME/.bin"
_path+=":$HOME/Library/Python/2.7/bin"
_path+=":$HOME/.tgenv/bin"
_path+=":$GOPATH/bin"
_path+=":$HOME/.gem/ruby/2.6.0/bin"
_path+=":${HOME}/.krew/bin"

PATH="$_path:$PATH"
source $HOME/.zshrc.secret

# --------------------------------------------------------------------------
# zsh related
# --------------------------------------------------------------------------
# Path to oh-my-zsh installation
ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="frisk-local"
ZSH_THEME="agnoster"
TERM="xterm-256color"

plugins=(
    aws
    git
    fly
    kubectl
    kube-ps1
    ssh-agent
    git-prompt
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
    git-it-on
    osx
)

# --------------------------------------------------------------------------
# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

source $ZSH/oh-my-zsh.sh
# source $HOME/.helm/helmenv.sh
# secrets kept here
source $HOME/.zshrc.secret

# --------------------------------------------------------------------------
# direnv
export DIRENV_WARN_TIMEOUT=120s
eval "$(direnv hook zsh)"

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
