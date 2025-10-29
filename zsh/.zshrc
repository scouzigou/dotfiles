# This is required when using powerlevel10k theme
if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi


export ZSH="$HOME/.oh-my-zsh"
#export ZSH_TMUX_AUTOSTART="true"
#export ZSH_TMUX_AUTOQUIT="false"

ZSH_THEME="bira"

plugins=(zsh-autosuggestions zsh-syntax-highlighting git zsh-z colored-man-pages colorize tmux)

source $ZSH/oh-my-zsh.sh

for x in ".zsh_env" ".zsh_aliases" ".zsh_pro"; do
  if [[ -f ${HOME}/$x ]]; then
    source $HOME/$x
  fi
done
