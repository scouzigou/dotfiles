
PACKAGES := base ntfs-3g xorg-xrandr lightdm lightdm-gtk-greeter i3-wm i3lock xss-lock picom feh rofi polybar firefox keepass
PACKAGES += wezterm yazi ttf-meslo-nerd zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting tmux git fzf bat
PACKAGES += lazygit xclip unzip wget neovim ripgrep lua51 luarocks fd nodejs npm python-pip python-pynvim stow exa man-db openssh
PACKAGES += libreoffice-fresh libreoffice-fresh-fr vlc

NPM_PACKAGES := tree-sitter-cli neovim

PACMAN := sudo pacman --noconfirm -S
NPM := sudo npm install -g

help:
	@echo "install packages with: 'make install_packages'"
	@echo "install rust with: 'make install_rust'"
	@echo "deploy config with: 'make deploy_configs'"
	@echo "configure keyboard (pc105, US, US intl) with: 'make configure_keyboard_us'"

install_packages:
	@$(PACMAN) $(PACKAGES)
	@$(NPM) $(NPM_PACKAGES)
	@[[ -d ${HOME}/.config/tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
	@[[ -d ${HOME}/.oh-my-zsh ]] || (curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh && mv ${HOME}/.zshrc ${HOME}/.zshrc.oh-my-zsh)
	@sudo systemctl enable lightdm

install_rust:
	@[[ -f ${HOME}/.cargo/bin/rustup ]] || curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
	@rustup component add rust-analyzer

deploy_configs:
	stow -t ${HOME} wezterm
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

