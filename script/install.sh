#!/bin/bash

set -e

# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/karstenmueller/dotfiles/master/script/install.sh)"

cd "$HOME"
rm -rf .dotfiles
git clone -c core.eol=lf -c core.autocrlf=false https://github.com/karstenmueller/dotfiles.git .dotfiles

bash .dotfiles/script/strap.sh
