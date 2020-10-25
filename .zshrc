GOPATH=~/go

_path+="$HOME/.bin"
_path+=":$HOME/Library/Python/2.7/bin"
_path+=":$HOME/.tgenv/bin"
_path+=":$GOPATH/bin"
_path+=":$HOME/.gem/ruby/2.6.0/bin"

PATH="$_path:$PATH"

# Path to your oh-my-zsh installation.
ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="frisk-local"
# ZSH_THEME="agnoster"
TERM="xterm-256color"

# See https://medium.com/@Clovis_app/configuration-of-a-beautiful-efficient-terminal-and-prompt-on-osx-in-7-minutes-827c29391961
# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
# # Add a space in the first prompt
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# # Visual customisation of the second prompt line
# local user_symbol="$"
# if [[ $(print -P "%#") =~ " #" ]]; then
#   user_symbol = "#"
# fi
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

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

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
# history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# fzf
export FZF_BASE=usr/local/bin/
# export DISABLE_FZF_AUTO_COMPLETION="true"
# export DISABLE_FZF_KEY_BINDINGS="true"

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

# enable ssh-agent forwarding support
zstyle :omz:plugins:ssh-agent agent-forwarding on
# load ssh identities
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_old

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc.secret

source $HOME/.helm/helmenv.sh

# User configuration
# export PROMPT='%25<...<%~%<<: '
#

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

# PROMPT=" $STAGE"
# source $HOME/.bin/kube-ps1.sh
# export PROMPT="$(kube_ps1)$PROMPT"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias src="cd ~/Source"
alias pre-commit-run="pre-commit run --all-files"
alias c.='code .'

# helmenv
# export PATH="$HOME/.bin:$PATH"
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# source $HOME/.helmenv/helmenv.sh

# aws
# complete -C '/usr/local/bin/aws_completer' aws

# google-cloud-sdk
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

alias fun-roll='curl -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias fun-star='nc towel.blinkenlights.nl 23'

alias aws-elb-names='aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].{ID:LoadBalancerName}" --output=json'
alias aws-elbv2-names='aws elbv2 describe-load-balancers --query "LoadBalancers[*].{ID:LoadBalancerName}" --output=json'

alias aws-elb-instances='aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].{ID:LoadBalancerName,InstanceId:Instances[*].InstanceId}[*]. {ELB:ID,InstanceId:InstanceId[*]}" --output=json'

alias aws-who='aws sts get-caller-identity; aws iam list-account-aliases'

function aws-elbv2-instances() {
  local ALB_NAME="$1"
  if [ "$ALB_NAME" != "" ]; then
    echo "ALB_NAME: $ALB_NAME"
  else
    echo "usage: aws-elbv2-instances <alb-name>"
    return
  fi
  local ALB_ARN=$(aws elbv2 describe-load-balancers --names "$ALB_NAME" --query 'LoadBalancers[0].LoadBalancerArn' --output text)
  local TG_ARN=$(aws elbv2 describe-target-groups --load-balancer-arn "$ALB_ARN" --query 'TargetGroups[0].TargetGroupArn' --output text)
  aws elbv2 describe-target-health --target-group-arn "$TG_ARN" --query 'TargetHealthDescriptions[*].Target.Id' --output text
}

# Kubernetes
export KUBERNETES_MASTER=""
export KUBE_EDITOR='code --wait'
# see https://github.com/ahmetb/kubectl-aliases
alias kx="kubectx"
alias kn="kubens"
alias kc='kubectl'
alias kgi='kubectl cluster-info'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgc='kubectl get componentstatuses'
alias kctx='kubectl config current-context'
alias kcon='kubectl config use-context'
alias kgc='kubectl config get-context'
alias kalias='alias | egrep "kx=|kn=|kc=|kgi=|kgp=|kgs=|kctx0|kcon=|kgc="'

# source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
# source <(stern --completion=zsh)
alias helm2='/usr/local/opt/helm@2/bin/helm'

eval "$(eksctl completion zsh)"

# -----------------------------------------------------------------------
# saml2aws
# -----------------------------------------------------------------------

function saml2aws-login() {
  saml2aws login --force
  eval "$(saml2aws script)"
}

function _saml-login() {
  local account="$1"
  local role="$2"
  local k8s_name="$3"
  export AWS_PROFILE="saml"
  echo saml2aws login --force --role="arn:aws:iam::${account}:role/${role}"
  saml2aws login --force --role="arn:aws:iam::${account}:role/${role}" --skip-prompt | grep "^Logged in as:" || echo "Login failed!"
  eval "$(saml2aws script)"
  if [ "$k8s_name" != "" ]; then
    export EKS_CLUSTER_NAME="${k8s_name}_fielmann_cloud"
    aws eks --region eu-central-1 update-kubeconfig --name "${k8s_name}_fielmann_cloud" >/dev/null
  fi
}

# Account: stage-prod (902076734849) / ae-ops-infrastructure
function slogin-stage-prod() {
  _saml-login "902076734849" "ae-ops-infrastructure"
}

function slogin-karsten() {
  _saml-login "463334463451" "ae-ops-infrastructure"
}

# Account: stage-test (285074506667) / product--version-monitor
function slogin-version-monitor() {
  _saml-login "285074506667" "product--version-monitor" "ae-test"
}

# Account: stage-test (285074506667) / ae-ops-infrastructure
function slogin-ae-test() {
  _saml-login "285074506667" "ae-ops-infrastructure" "ae-test"
}

# Account: stage-mgmt (720927046408) / ae-ops-infrastructure
function slogin-ae-mgmt() {
  _saml-login "720927046408" "ae-ops-infrastructure" "ae-mgmt"
}

# function _saml2aws_precmd() {
#   eval "$(saml2aws script)"
# }
# add-zsh-hook -d precmd _saml2aws_precmd

# See get-saml2aws-config

# export stage="test"
# saml2aws login --idp-account stage-"$stage" --force --skip-prompt
# saml2aws exec --profile stage-"$stage" -- aws sts get-caller-identity
# saml2aws exec --profile stage-"$stage" -- aws --profile stage-"$stage" --region eu-central-1 eks update-kubeconfig --name ae-"$stage"_fielmann_cloud
# saml2aws exec --profile stage-"$stage" -- kubectl cluster-info
# EQUALS:
# source ~/.zshrc; sal test; said test; saprompt; sae test kubectl cluster-info

alias sa='saml2aws'
alias salr="saml2aws list-roles --skip-prompt"

# function sal() {
#   local stage="$1"
#   saml2aws login --idp-account stage-"$stage" \
#     --force --skip-prompt --session-duration="$SAML2AWS_LOGIN_SESSION_DURATION"
#   sae "$stage" aws --profile stage-"$stage" --region eu-central-1 eks update-kubeconfig --name ae-"$stage"_fielmann_cloud
#   _saprompt_prepare stage-"$stage"
# }

# function sae() {
#   local stage="$1"
#   shift
#   saml2aws exec --profile stage-"$stage" --session-duration="$SAML2AWS_LOGIN_SESSION_DURATION" -- "$@"
# }

# function said() {
#   local stage="$1"
#   shift
#   saml2aws exec --profile stage-"$stage" -- aws sts get-caller-identity "$@"
# }

# function sac() {
#   local login_url
#   login_url="$(_saml2aws_getSigninTokenUrl)"

#   profile=${1:-$SAML2AWS_PROFILE}
#   profile=${profile:-saml}

#   open -a Safari "${login_url}"
# }

# function _saml2aws_urlencode() {
#   echo "$1" | python -c 'import urllib, sys; sys.stdout.writelines(urllib.quote_plus(l, safe="/\n") for l in sys.stdin)'
# }

# function _saml2aws_getSigninTokenUrl() {
#   session=$( (
#     eval "$(saml2aws script)"
#     sh -c 'echo "{\"sessionId\": \"$AWS_ACCESS_KEY_ID\",\"sessionKey\":\"$AWS_SECRET_ACCESS_KEY\",\"sessionToken\":\"$AWS_SECURITY_TOKEN\"}"'
#   ))
#   signinToken=$(curl -s -G https://signin.aws.amazon.com/federation --data-urlencode "Action=getSigninToken" --data-urlencode "SessionDuration=43200" --data-urlencode "Session=$session" | python -c "import json,sys; print json.load(sys.stdin)['SigninToken']")

#   if [[ -z "$signinToken" ]]; then
#     echo "Could not sign in with current profile." >&2
#     exit 1
#   fi

#   consoleUrl=$(_saml2aws_urlencode "https://console.aws.amazon.com/console/home?region=$AWS_DEFAULT_REGION")

#   echo "https://signin.aws.amazon.com/federation?Action=login&Issuer=$(_saml2aws_urlencode "$SAML2AWS_URL")&Destination="$consoleUrl"&SigninToken="$signinToken""
# }

function saprompt() {
  if [[ -v AWS_PROFILE ]]; then
    CYAN="$(tput setaf 6)"
    RESET=$(tput sgr0)
    printf "$CYAN(saml2aws $AWS_PROFILE: $AWS_CREDS_EXPIRE)\n$RESET"
    # printf "(saml2aws $AWS_PROFILE expires: $AWS_CREDS_EXPIRE)"
  fi
}

function _saprompt_prepare() {
  # saml2aws
  if [[ -z "$1" ]]; then # if you run it with no profile name, it unsets the variables
    unset AWS_PROFILE
    unset AWS_CREDS_EXPIRE
  else
    export AWS_CREDS_EXPIRE=$(
      python3 - "$1" <<END
import configparser
import sys
import os
cred_file = os.environ['HOME'] + "/.aws/credentials"
account = sys.argv[1]
config = configparser.ConfigParser()
config.sections()
config.read(cred_file)
try:
  expire_string = config[account]['x_security_token_expires']
  print(expire_string[11:19])
except KeyError:
  print("account: ", account, "unset")
END
    )
    export AWS_PROFILE=$1
  fi
}
# saml2aws
# -----------------------------------------------------------------------

alias git-open=gitit

function git-clean-gone() {
  git fetch -p
  for branch in $(git branch -vv --no-color | grep ': gone]' | awk '{print $1}'); do
    git branch -D "$branch"
  done
}
# git-commits-behind:
# git diff --stat feature/version-monitor origin/feature/version-monitor
alias git-reset='git fetch origin; git reset --hard @{u}'
# add GitHub PRs to origin. Use with 'git fetch origin'
alias git-add-pr="git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'"

alias docker-prune='docker system prune -af'
alias docker-run-ubuntu='docker run  -v `pwd`:`pwd` -w `pwd` -i -t  ubuntu /bin/bash'
alias docker-run-kali='docker run -t -i kalilinux/kali-linux-docker /bin/bash'
alias docker-run-testssl='docker run -t -i drwetter/testssl.sh'
alias docker-code-server='docker run -it -p 127.0.0.1:8080:8080 -v "$PWD:/home/coder/project" -u "$(id -u):$(id -g)" codercom/code-server:latest --auth none'

# alias docker-run-gateone="docker rm -f $(docker ps -aqf name='^gateone') > /dev/null 2>&1; docker run -d --name=gateone -p 443:8000 arush/gateone; sleep 2; open -a 'Google Chrome' https://localhost:443/"

# function yq() {
#   docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
# }

alias multipass-prune="multipass delete --all; multipass purge"

alias getip='curl -s https://api.ipify.org'
alias mtr='sudo /usr/local/sbin/mtr'
alias brew-update='brew update; brew bundle check --global || brew bundle --global; brew link tfenv'
alias ssl_cert_show='openssl x509 -text -noout -in '
alias zshrc='code --new-window --wait ~/.zshrc; source ~/.zshrc'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
