# Dotfiles

This is is the `kiss` version of my dotfiles.

## Install

- install [`stow`](https://archlinux.org/packages/extra/any/stow/)

~~~bash
# pre-requisite, install stow
sudo pacman -Sy stow
~~~

- clone the repository locally (for example in `.dotfiles`)

~~~bash
git clone --branch kiss https://github.com/scouzigou/dotfiles.git .dotfiles
~~~

- deploy config files using `stow`

~~~bash
# Example: deploy a single app
# stow --dotfiles --target $HOME <app folder>
# Examples
stow --dotfiles --target $HOME tmux
stow --dotfiles --target $HOME kitty
# ...
~~~
