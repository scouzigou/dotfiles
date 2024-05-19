LAZYGIT_VERSION := "0.42.0"


local_bin:
	mkdir -p ${HOME}/.local/bin

lazygit: local_bin
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	install lazygit ${HOME}/.local/bin
	rm -rf lazygit.tar.gz lazygit

tmux:
	rm -rf ${HOME}/.tmux ${HOME}/.tmux.conf ${HOME}/.config/tmux
	git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
	ln -vsf ${PWD}/.config/tmux/tmux.conf ${HOME}/.config/tmux/tmux.conf

install: lazygit tmux
