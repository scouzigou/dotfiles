
PACKAGES := base ntfs-3g xorg-xrandr lightdm lightdm-gtk-greeter i3-wm i3lock xss-lock picom feh rofi polybar firefox keepass
PACKAGES += alacritty wezterm yazi ttf-meslo-nerd zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting tmux git fzf bat
PACKAGES += lazygit xclip unzip wget neovim ripgrep fd nodejs npm python-pip python-pynvim stow exa man-db openssh

NPM_PACKAGES := tree-sitter-cli neovim

PACMAN := sudo pacman --noconfirm -S
NPM := sudo npm install -g

help:
	@echo "deploy config with: 'make deploy_configs'"
	@echo "install packages with: 'make install_packages'"
	@echo "configure keyboard (pc105, US, US intl) with: 'make configure_keyboard_us'"
	@echo "install rust with: 'make install_rust'"

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

configure_keyboard_us:
	@sudo localectl --no-convert set-keymap us
	@sudo localectl --no-convert set-x11-keymap us,us pc105,pc105 "",intl grp:ctrl_alt_toggle

install_packages:
	$(PACMAN) $(PACKAGES)
	$(NPM) $(NPM_PACKAGES)
	[[ -d ${HOME}/.config/tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm

install_rust:
	@[[ -f ${HOME}/.cargo/bin/rustup ]] || curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
	@rustup component add rust-analyzer
