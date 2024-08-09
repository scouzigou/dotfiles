
PACKAGES := base ntfs-3g xorg-xrandr lightdm lightdm-gtk-greeter imagemagick i3-wm i3lock xss-lock picom feh rofi polybar firefox keepass
PACKAGES += wezterm yazi ttf-meslo-nerd zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting tmux git fzf bat
PACKAGES += lazygit xclip unzip wget neovim ripgrep lua51 luarocks fd nodejs npm python-pip python-pynvim stow exa man-db openssh
PACKAGES += libreoffice-fresh libreoffice-fresh-fr vlc

PACKAGES_PRINTER := usbutils cups cups-pdf hplip sane skanpage

NPM_PACKAGES := tree-sitter-cli neovim

PACMAN := sudo pacman --noconfirm -S
NPM := sudo npm install -g

help:
	@echo "install packages with: 'make install_packages'"
	@echo "install printer with: 'make install_printer'"
	@echo "install rust with: 'make install_rust'"
	@echo "deploy config with: 'make deploy_configs'"
	@echo "configure keyboard layouts (pc105, US, US intl, FR) with: 'make configure_keyboard_layouts'"

install_packages:
	@$(PACMAN) $(PACKAGES)
	@$(NPM) $(NPM_PACKAGES)
	@[[ -d ${HOME}/.config/tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
	@[[ -d ${HOME}/.oh-my-zsh ]] || (curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh && mv ${HOME}/.zshrc ${HOME}/.zshrc.oh-my-zsh)

install_printer:
	@$(PACMAN) $(PACKAGES_PRINTER)
	@sudo systemctl enable cups
	@echo -e "####\nRun sudo hp-setup -i to finalize the installation\n####"

install_rust:
	@[[ -f ${HOME}/.cargo/bin/rustup ]] || curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
	@rustup component add rust-analyzer

configure_lightdm:
	@[[ -f /etc/lightdm/lightdm.conf.original ]] || sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.original
	@sudo cp ./lightdm/lightdm.conf /etc/lightdm/lightdm.conf
	@[[ -f /etc/lightdm/lightdm-gtk-greeter.conf.original ]] || sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.original
	@sudo cp ./lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
	@[[ -d /usr/share/backgrounds/lightdm ]] || (sudo mkdir -p /usr/share/backgrounds/lightdm && sudo chown lightdm:root /usr/share/backgrounds/lightdm/)
	@[[ -f /usr/share/backgrounds/lightdm/wallpaper-blur.jpg ]] || (sudo cp ./backgrounds/.config/backgrounds/wallpaper-blur.jpg /usr/share/backgrounds/lightdm/ && sudo chown lightdm:root /usr/share/backgrounds/lightdm/wallpaper-blur.jpg)
	@sudo systemctl enable lightdm

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
	stow -t ${HOME} yazi
	stow -t ${HOME} zsh

configure_keyboard_layouts:
	@sudo localectl --no-convert set-keymap us
	@sudo localectl --no-convert set-x11-keymap us,us,fr pc105,pc105,pc105 "",intl,"" grp:ctrl_shift_toggle

