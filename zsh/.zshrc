export ZSH="$HOME/.oh-my-zsh"
#export ZSH_TMUX_AUTOSTART="true"
#export ZSH_TMUX_AUTOQUIT="false"

ZSH_THEME="robbyrussell"

plugins=(git z fzf colored-man-pages colorize tmux)

source $ZSH/oh-my-zsh.sh

zsh_files=".zsh_aliases .zsh_env"
for x in $(echo $zsh_files); do
  if [[ -f ${HOME}/$x ]]; then
    source $HOME/$x
  fi
done

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
