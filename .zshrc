# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setting the zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Custom variables
COMPLETIONS_DIR="$HOME/.zsh"

# Download zinit, if it's not present
if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

# Load completions
if [ ! -d $COMPLETIONS_DIR ]; then
  mkdir -p "$(dirname $COMPLETION_DIR)"
fi

if [ $(command -v rustup) ] && [ ! -d "$COMPLETIONS_DIR/_rustup" ]; then
  rustup completions zsh > "$COMPLETIONS_DIR/_rustup"
fi

if [ $(command -v rustup) ] && [ ! -d "$COMPLETIONS_DIR/_cargo" ]; then
  rustup completions zsh cargo > "$COMPLETIONS_DIR/_cargo"
fi

if [ $(command -v fnm) ] && [ ! -d "$COMPLETIONS_DIR/_fnm" ]; then
  fnm completions --shell zsh > "$COMPLETIONS_DIR/_fnm"
fi

if [ $(command -v arduino-cli) ] && [ ! -d "$COMPLETIONS_DIR/_arduino_cli" ]; then
  arduino-cli completion zsh > "$COMPLETIONS_DIR/_arduino-cli"
fi

fpath+=$COMPLETIONS_DIR
autoload -U compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
# bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUPE=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls="ls --color"
alias vim="nvim"

# Shell integrations
eval "$(fzf --zsh)"


# fnm
FNM_PATH="/home/luis/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/luis/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# zoxide
if [ $(command -v zoxide) ]; then
  eval "$(zoxide init --cmd cd zsh)"
fi
