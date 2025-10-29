LAZYGIT_VERSION := "0.42.0"

local_bin:
	mkdir -p ${HOME}/.local/bin

lazygit: local_bin
	curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf /tmp/lazygit.tar.gz -C /tmp
	install /tmp/lazygit ${HOME}/.local/bin
	rm -rf /tmp/lazygit.tar.gz /tmp/lazygit

tmux:
	rm -rf ${HOME}/.tmux ${HOME}/.tmux.conf ${HOME}/.config/tmux
	git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
	ln -vsf ${PWD}/.config/tmux/tmux.conf ${HOME}/.config/tmux/tmux.conf

zshrc: oh_my_zsh exa
	rm -rf ${HOME}/.zshrc ${HOME}/.zsh_aliases
	ln -vsf ${PWD}/.zsh_aliases ${HOME}/.zsh_aliases
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc

oh_my_zsh:
	rm -rf ${HOME}/.oh-my-zsh ${HOME}/.p10k.zsh
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o/tmp/install.sh && \
	export RUNZSH="no" && \
	sh /tmp/install.sh && \
	rm /tmp/install.sh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.oh-my-zsh/themes/powerlevel10k
	ln -vsf ${PWD}/.p10k.zsh ${HOME}/.p10k.zsh

exa: cargo
	cargo install exa

cargo:
	sudo apt install cargo


install: lazygit tmux zshrc
