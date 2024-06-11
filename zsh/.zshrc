# This is required when using powerlevel10k theme
if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
#export ZSH_TMUX_AUTOSTART="true"
#export ZSH_TMUX_AUTOQUIT="false"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(zsh-autosuggestions zsh-syntax-highlighting git zsh-z colored-man-pages colorize tmux)

source $ZSH/oh-my-zsh.sh

for x in ".zsh_env" ".zsh_aliases" ".zsh_pro"; do
  if [[ -f ${HOME}/$x ]]; then
    source $HOME/$x
  fi
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
