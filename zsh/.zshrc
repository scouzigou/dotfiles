export ZSH="$HOME/.oh-my-zsh"
#export ZSH_TMUX_AUTOSTART="true"
#export ZSH_TMUX_AUTOQUIT="false"

ZSH_THEME="bira"

plugins=(zsh-autosuggestions zsh-syntax-highlighting git zsh-z colored-man-pages colorize tmux)

source $ZSH/oh-my-zsh.sh

zsh_files=".zsh_aliases .zsh_env"
for x in $(echo $zsh_files); do
  if [[ -f ${HOME}/$x ]]; then
    source $HOME/$x
  fi
done
