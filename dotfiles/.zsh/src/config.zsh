export ZDOTDIR=~/.zsh

# devbox
eval "$(devbox global shellenv --init-hook)"
export DEVBOX_NO_PROMPT=true

# exports
WIN_PATHS=''
export PATH="/usr/bin:/usr/local/bin:$PATH"
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export EDITOR="subl"
export LESS="-RFX"

# zsh-defer
source $HOME/.config/zsh/zsh-defer/zsh-defer.plugin.zsh

# oh my zsh
export OH_MY_ZSH="$HOME/.config/zsh/oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
  git
  zsh-autosuggestions
  zsh-shift-select
  you-should-use
  # fast-syntax-highlighting
  zsh-syntax-highlighting
)
source $OH_MY_ZSH/oh-my-zsh.sh
autoload -Uz compinit
compinit

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
eval "$(starship init zsh)"

# zoxide
zsh-defer eval "$(zoxide init --cmd cd zsh)"

# fzf
FZF_FD_OPTS="--hidden --follow --exclude '.git'"
export FZF_DEFAULT_OPTS="--layout=default"
export FZF_DEFAULT_COMMAND="fdfind ${FZF_FD_OPTS}"
export FZF_CTRL_T_COMMAND="fdfind ${FZF_FD_OPTS}"
export FZF_ALT_C_COMMAND="fdfind --type d ${FZF_FD_OPTS}"
_fzf_compgen_path() {
    fdfind ${FZF_FD_OPTS} . "${1}"
}
_fzf_compgen_dir() {
    fdfind --type d ${FZF_FD_OPTS} . "${1}"
}
# ls -l ~/.config/fzf/key-bindings.zsh
source $HOME/.config/fzf/key-bindings.zsh

# direnv
export DIRENV_LOG_FORMAT=""
zsh-defer eval "$(direnv hook zsh)"

# mcfly
export MCFLY_FUZZY=2
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_DISABLE_MENU=TRUE
zsh-defer eval "$(mcfly init zsh)"

# ctrl + backspace
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# unbind Ctrl + s
bindkey -r '^S'

# CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export GALLIUM_DRIVER=d3d12
export MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA

# VcXsrv
export DISPLAY=$(ip route | grep default | awk '{print $3}'):0.0
export LIBGL_ALWAYS_INDIRECT=0
export LIBGL_ALWAYS_SOFTWARE=true

# utils
for file in $HOME/.config/zsh/utils/*.zsh; do
    source $file
done
