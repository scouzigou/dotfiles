
PACKAGES := base lightdm lightdm-gtk-greeter i3-wm i3lock xss-lock picom feh rofi polybar firefox keepass
PACKAGES += alacritty ttf-meslo-nerd zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting tmux git
PACKAGES += lazygit xclip unzip wget neovim ripgrep fd nodejs npm python-pip python-pynvim stow exa man-db

NPM_PACKAGES := tree-sitter-cli neovim

PACMAN := sudo pacman --noconfirm -S
NPM := sudo npm install -g

help:
	@echo "deploy config with the command: 'make deploy_configs'"
	@echo "install packages with the command: 'make install_packages'"

deploy_configs:
	@$(PACMAN) stow
	stow -t ${HOME} alacritty
	stow -t ${HOME} backgrounds
	stow -t ${HOME} bin
	stow -t ${HOME} gitconfig
	stow -t ${HOME} i3
	stow -t ${HOME} neovim
	stow -t ${HOME} picom
	stow -t ${HOME} polybar
	stow -t ${HOME} rofi
	stow -t ${HOME} tmux
	stow -t ${HOME} zsh

install_packages:
	$(PACMAN) $(PACKAGES)
	$(NPM) $(NPM_PACKAGES)
	[[ -d ${HOME}/.config/tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm

