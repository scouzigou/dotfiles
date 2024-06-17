# dotfiles

### Manually deploy configuration

Using `stow`:

~~~bash
#stow --target=$HOME <package>
# Examples
stow --target=$HOME zsh
stow --target=$HOME gitconfig
stow --target=$HOME tmux
stow --target=$HOME neovim
...
~~~

### Automatic deployment with `make`

Look at `Makefile`:

~~~bash
make deploy_configs # this will install stow
make install_packages
~~~
