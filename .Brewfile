cask_args appdir: '/Applications'

# Taps
tap 'homebrew/core'             # -- Core formulae for the Homebrew package manager
tap 'homebrew/bundle'           # -- Bundler for non-Ruby dependencies from Homebrew, Homebrew Cask, Mac App Store and Whalebrew
tap 'homebrew/services'         # -- Manage background services with macOS' launchctl daemon manager.

# control external displays
cask 'lunar'                    # -- Adaptive brightness for external displays

# Docker
cask 'docker'
# kubectl lives in Docker App

# Kubernetes
tap 'johanhaleby/kubetail'      # -- aggregate (tail/follow) logs from multiple pods into one stream
brew 'stern'                    # -- Tail multiple Kubernetes pods & their containers
brew 'kubectx'                  # -- Tool that can switch between kubectl contexts easily and create aliases
brew 'krew'                     # -- Package manager for kubectl plugins
brew 'kube-ps1'                 # -- Kubernetes prompt info for bash and zsh
# brew 'derailed/k9s/k9s'       # -- provides a terminal UI to interact with your Kubernetes clusters
# brew 'minikube'               # -- Run a Kubernetes cluster locally
# Operator SDK
# brew 'operator-sdk'           # -- SDK for building Kubernetes applications
# brew 'derailed/popeye/popeye' # -- A Kubernetes Cluster Sanitizer

# Helm
brew 'helm'                     # -- Kubernetes package manager
# brew 'helm@2'
brew 'helmfile'                 # -- Deploy Kubernetes Helm Charts
# tap 'helm/tap'  
# brew 'chart-releaser'         # -- Helps Turn GitHub Repositories into Helm Chart Repositories

# Cloud azure
# brew 'azure/draft/draft'
# brew 'azure-cli'

# Cloud google
# cask 'google-cloud-sdk'       

# Cloud aws
# tap 'versent/homebrew-taps'
# brew 'saml2aws'               # -- enables you to login and retrieve AWS temporary credentials using with ADFS or PingFederate Identity Providers
brew 'awscli'                   # -- Official Amazon AWS command-line interface
cask 'session-manager-plugin'   # -- Plugin for AWS CLI to start and end sessions that connect to managed instances
# tap 'weaveworks/tap'
# brew 'weaveworks/tap/eksctl'  # -- a CLI tool for creating clusters on EKS 
cask 'aws-vault'                # -- tool to securely store and access AWS credentials in a development environment
# brew 'awsume'                 # -- Utility for easily assuming AWS IAM roles from the command-line

# brew 'packer'                 # -- Tool for creating identical machine images for multiple platforms
# cask 'multipass'              # -- Orchestrates virtual Ubuntu instances

# Terraform
# brew 'graphviz'               # -- Graph visualization software from AT&T and Bell Labs
# terraform installed by tfenv
brew 'tfenv', link: true        # -- Terraform version manager
brew 'tflint'                   # -- Linter for Terraform files
brew 'terraform-docs'           # -- Tool to generate documentation from Terraform modules
# terragrunt installed by tgenv
tap 'alextodicescu/tgenv'
brew 'tgenv', link: true        # -- Terragrunt version manager

# Microsoft related
# cask 'powershell'             # -- Command-line shell and scripting language
# brew 'unix2dos'               # -- Convert text between DOS, UNIX, and Mac formats

# Font related
tap 'homebrew/cask-fonts'
cask 'font-source-code-pro'
cask 'font-source-sans-pro'
#cask 'font-fantasque-sans-mono'
brew 'highlight'                # -- Convert source code to formatted text with syntax highlighting

# QuickLook
# See https://github.com/sindresorhus/quick-look-plugins
# cask 'betterzip'              # -- Utility to create and modify archives
# cask 'quicklook-json'         # -- preview JSON files

# git tools
# brew 'git'                    # -- Distributed revision control system --> Better use macOS git 
brew 'gitup'                    # -- Git interface focused on visual interaction
brew 'git-secret'               # -- Prevents you from committing sensitive information to a git repo
brew 'pre-commit'               # -- Framework for managing multi-language pre-commit hooks

# GitHub tools
brew 'gh'                       # -- GitHub’s official command line tool
brew 'gitversion'               # -- semantic versioning
brew 'git-credential-manager'   # -- Stores Git credentials
# tap 'nektos/tap'
# brew 'nektos/tap/act'         # -- Run your GitHub Actions locally

# Editor & Terminal tools
# cask 'visual-studio-code'     # -- Open-source code editor
cask 'alacritty'                # -- Cross-platform, GPU-accelerated terminal emulator
brew 'ripgrep'                  # -- a line-oriented search tool that recursively searches your current directory for a regex pattern.
brew 'tmux'                     # -- Terminal multiplexer

# yaml / json
brew 'jq'                       # -- command-line JSON processor
brew 'yq'                       # -- Process YAML documents from the CLI
brew 'yamllint'                 # -- Linter for YAML files
# tap 'starkandwayne/cf'        # -- BOSH / Cloud Foundry / Kubernetes utilities
# brew 'spruce'                 # -- a general purpose YAML & JSON merging tool
cask 'postman'                  # -- Collaboration platform for API development

# Shell tools
brew 'fzf'                      # -- Command-line fuzzy finder written in Go
brew 'direnv'                   # -- Load/unload environment variables based on $PWD
brew 'shellcheck'               # -- Static analysis and lint tool, for (ba)sh scripts

# dev Node.js
brew 'node'                     # -- Platform built on V8 to build network applications

# dev Ruby
# brew 'rbenv'                  # -- ruby version manager
# brew 'ruby-build'             # -- Install various Ruby versions and implementations

# dev Go 
# brew 'golang'                 # -- programming language
# brew 'dep'                    # -- DEPRECATED dependency management tool for Go

# dev Kubernetes
# brew 'skaffold'               # -- cli tool that facilitates continuous development for Kubernetes applications.

# miscellaneous tools
# brew 'dialog'                 # -- Script-driven curses widgets (application and library)
# brew 'pandoc'                 # -- a universal document converter
# brew 'watch'                  # -- procps
# brew 'mosh'                   # -- mobile shell / Remote terminal application
# brew 'nmap'                   # -- utility for network discovery and security auditing
brew 'coreutils'                # -- GNU core utilities
brew 'tree'                     # -- recursive directory listing command
brew 'mtr'                      # -- improved traceroute
brew 'keychain'                 # -- helps you to manage SSH and GPG keys in a convenient and secure manner
brew 'wget'                     # -- retrieves content from web servers
# brew 'hugo'                   # -- framework for building websites
# brew 'miniupnpc'              # -- enabling applications to access the services provided by an UPnP "Internet Gateway Device"

# more messengers ;)
# cask 'slack'
cask 'telegram'
# cask 'signal'

# miscellaneous apps
# cask 'dropbox'                # -- Client for the Dropbox cloud storage service
# cask 'alfred'                 # -- Application launcher and productivity software
# cask 'caffeine'               # -- Utility that prevents the system from going to sleep
# cask 'google-chrome'          # -- Web Browser
# cask 'hazel'                  # -- Automated organization
# cask 'calibre'                # -- E-books management software
cask 'grandperspective'         # -- Graphically shows disk usage within a file system
# cask 'atext'                  # -- Tool to replace abbreviations while typing
# cask 'openconnect-gui'        # -- Graphical OpenConnect client
# cask '1password-cli'          # -- Command-line helper for the 1Password password manager
# cask 'drawio'                 # -- free online diagram software
