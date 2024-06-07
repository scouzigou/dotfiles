tmux:
	ln -vsf ${PWD}/.config/tmux/tmux.conf ${HOME}/.config/tmux/tmux.conf

bins: | ${HOME}/.local/bin
	ln -vsf ${PWD}/.local/bin/* ${HOME}/.local/bin

${HOME}/.local/bin:
	mkdir -p $@

zsh:
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.zsh_aliases ${HOME}/.zsh_aliases
	ln -vsf ${PWD}/.zsh_env ${HOME}/.zsh_env
	ln -vsf ${PWD}/.p10k.zsh ${HOME}/.p10k.zsh

lazyvim:
	rm -rf ${HOME}/.local/share/nvim
	rm -rf ${HOME}/.local/state/nvim
	rm -rf ${HOME}/.cache/nvim
	rm -rf ${HOME}/.config/nvim
	ln -vsf ${PWD}/.config/nvim ${HOME}/.config

gitconfig:
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig

install: tmux bins zsh lazyvim gitconfig

