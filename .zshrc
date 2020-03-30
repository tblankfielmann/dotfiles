#!/bin/bash

# If you come from bash you might have to change your $PATH.
PYTHON_BIN="$HOME/Library/Python/2.7/bin"
export PATH=$HOME/.bin:$GOPATH/bin:/usr/local/bin:$PYTHON_BIN:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export ZSH_THEME="frisk-local"

# ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions ssh-agent git-prompt)

# enable ssh-agent forwarding support
zstyle :omz:plugins:ssh-agent agent-forwarding on
# load ssh identities
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_old

source $ZSH/oh-my-zsh.sh

# User configuration
# export PROMPT='%25<...<%~%<<: '

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

eval "$(direnv hook zsh)"

export GOPATH=~/go

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias src="cd ~/Source"

# complete -C '/usr/local/bin/aws_completer' aws

export KUBE_EDITOR='code --wait'

function git-open() {
  if [ "$(uname -s)" = "Darwin" ]; then
    browser="open"
  else
    browser="xdg-open"
  fi

  local repo_url="$(git remote -v | head -1 | cut -f2 | cut -f1 -d' ' | sed -e 's/git@//' -e 's/\:v3//' -e 's/ssh\.//')"

  if echo "$repo_url" | grep -q "dev.azure.com"; then
    echo "TODO: insert '_git' before lat part of path"
    return
  fi

  if ! echo "$repo_url" | grep -q "^https"; then
    repo_url="https://$repo_url"
  fi

  $browser "$repo_url"
}
alias git-open=git-open

function git-clean() {
  git fetch -p
  for branch in $(git branch -vv --no-color | grep ': gone]' | awk '{print $1}'); do
    git branch -D "$branch"
  done
}
alias git-clean=git-clean
alias git-reset='git fetch origin; git reset --hard @{u}'

alias docker-prune='docker system prune -af'
alias docker-run-ubuntu='docker run -t -i ubuntu:latest'
alias docker-run-kali='docker run -t -i kalilinux/kali-linux-docker /bin/bash'
alias docker-run-testssl='docker run -t -i drwetter/testssl.sh'

alias multipass-prune="multipass delete --all; multipass purge"

alias getip='curl -s https://api.ipify.org'
alias mtr='sudo /usr/local/sbin/mtr'
alias brew-update='brew update; brew bundle check --global || brew bundle --global'
alias ssl_cert_show='openssl x509 -text -noout -in '
alias zshrc='code --new-window --wait ~/.zshrc; source ~/.zshrc'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
