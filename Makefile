LAZYGIT_VERSION := "0.42.0"

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


install: tmux bins zsh

