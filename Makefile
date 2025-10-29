CONFIG_DIR = $(HOME)/.config
LOCAL_DIR = $(HOME)/.local
LOCAL_BIN_DIR = $(HOME)/.local/bin
KEEPASS_DIR = $(HOME)/.keepass

PACMAN_PACKAGES := base man-db openssh ntfs-3g usbutils cups cups-pdf hplip sane ttf-meslo-nerd
PACMAN_PACKAGES += xorg-xrandr lightdm lightdm-gtk-greeter i3-wm i3lock xss-lock picom feh rofi polybar xclip
PACMAN_PACKAGES += firefox keepass wezterm libreoffice-fresh libreoffice-fresh-fr skanpage vlc
PACMAN_PACKAGES += zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting
PACMAN_PACKAGES += imagemagick yazi tmux git lazygit fzf bat unzip wget ripgrep fd stow exa
PACMAN_PACKAGES += neovim lua51 luarocks fd nodejs npm python-pip python-pynvim

NPM_NEOVIM_PACKAGES := tree-sitter-cli neovim


MKINSTALLDIRS = mkdir -p
PACMAN := sudo pacman -Sy --noconfirm --needed 
NPM := sudo npm install -g

.PHONY: install

help:
	@echo "use 'make install' to install and configure your environment"
	@echo "warning: there is no 'make clean' => look at the Makefile first!"

install: directories
	@echo "Installing..."
	@# Arch packages
	@$(PACMAN) $(PACMAN_PACKAGES)
	@# NodeJS packages (required by neovim)
	@$(NPM) $(NPM_NEOVIM_PACKAGES)
	@# Tmux Plugin Manager
	@[[ -d ${HOME}/.config/tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
	@# Oh-My-Zsh
	@[[ -d ${HOME}/.oh-my-zsh ]] || (curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh && mv ${HOME}/.zshrc ${HOME}/.zshrc.oh-my-zsh)
	@# Rust
	@[[ -f ${HOME}/.cargo/bin/rustup ]] || curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
	@rustup component add rust-analyzer
	@echo "Configuring..."
	@# Update /usr/share/applications/keepass.desktop to make it appears into rofi menu (see rofi/config.rasi)
	@sudo sed -i 's/^Categories=Utility;$$/Categories=Utility;Keepass;/' /usr/share/applications/keepass.desktop
	@# Configure lightdm
	@[[ -f /etc/lightdm/lightdm.conf.original ]] || sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.original
	@[[ -f /etc/lightdm/lightdm-gtk-greeter.conf.original ]] || sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.original
	@[[ -d /usr/share/backgrounds/lightdm ]] || (sudo mkdir -p /usr/share/backgrounds/lightdm && sudo chown lightdm:root /usr/share/backgrounds/lightdm/)
	@[[ -f /usr/share/backgrounds/lightdm/wallpaper-blur.jpg ]] || (sudo cp ./backgrounds/dot-config/backgrounds/wallpaper-blur.jpg /usr/share/backgrounds/lightdm/ && sudo chown lightdm:root /usr/share/backgrounds/lightdm/wallpaper-blur.jpg)
	@sudo cp ./lightdm/lightdm.conf /etc/lightdm/lightdm.conf
	@sudo cp ./lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
	@# Stow various configurations
	@stow -t ${HOME} --dotfiles backgrounds
	@stow -t ${HOME} --dotfiles bin
	@stow -t ${HOME} --dotfiles gitconfig
	@stow -t ${HOME} --dotfiles i3
	@stow -t ${HOME} --dotfiles markdownlint-cli2
	@stow -t ${HOME} --dotfiles neovim
	@stow -t ${HOME} --dotfiles picom
	@stow -t ${HOME} --dotfiles polybar
	@stow -t ${HOME} --dotfiles rofi
	@stow -t ${HOME} --dotfiles tmux
	@stow -t ${HOME} --dotfiles wezterm
	@stow -t ${HOME} --dotfiles yazi
	@stow -t ${HOME} --dotfiles zsh
	@# Configure keyboard layouts (us, us intl, fr)
	@sudo localectl --no-convert set-keymap us
	@sudo localectl --no-convert set-x11-keymap us,us,fr pc105,pc105,pc105 "",intl,"" grp:ctrl_shift_toggle
	@echo "Enabling services..."
	@sudo systemctl enable lightdm
	@sudo systemctl enable cups
	@# Configure printer
	@sudo hp-setup -b usb -i -a -x
	
directories:
	$(MKINSTALLDIRS) $(CONFIG_DIR) $(LOCAL_DIR) $(LOCAL_BIN_DIR) $(KEEPASS_DIR)

.PHONY: clean

clean:
	@ echo "Cleaning up..."
