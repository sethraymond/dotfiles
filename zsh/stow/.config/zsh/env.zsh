# Environment and PATH

# zsh exposes PATH as the tied array $path. -U keeps entries unique.
typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "$HOME/neovim/bin"
  "$HOME/go/bin"
  /usr/local/go/bin
  /opt/forticlient
  $path
)

export MANPATH="/usr/local/man:${MANPATH:-}"
export EDITOR="vim"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#646669"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent-proxy.sock"

# Machine/user-specific environment values.
[[ -r "$HOME/.env" ]] && source "$HOME/.env"
