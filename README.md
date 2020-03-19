# Install dotfiles and bootstrap macOS

Configure the [strap.sh](script/strap.sh) environment in a file and source it.

~~~zsh
# used for configuring your box
export STRAP_GIT_NAME='Jane Doe'
export STRAP_GIT_EMAIL='jane@example.com'
# used for accessing personal dotfiles repo
export STRAP_GITHUB_USER='janedoe'
export STRAP_GITHUB_TOKEN='861bf1x18b3729152942c86164ad6d46898e3233'
~~~

Install dotfiles and bootstrap:

~~~zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/karstenmueller/dotfiles/master/script/install.sh)"
~~~
