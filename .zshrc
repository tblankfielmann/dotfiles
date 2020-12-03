# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
    zsh-syntax-highlighting
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
