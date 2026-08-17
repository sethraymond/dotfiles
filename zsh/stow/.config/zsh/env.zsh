# Environment and PATH

# zsh exposes PATH as the tied array $path. -U keeps entries unique.
typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "$HOME/go/bin"
  $path
)

for tool_path in /opt/forticlient /usr/local/go/bin "$HOME/neovim/bin"; do
  [[ -d "$tool_path" ]] && path=("$tool_path" $path)
done
unset tool_path

export MANPATH="/usr/local/man:${MANPATH:-}"
export EDITOR="vim"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#646669"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent-proxy.sock"

# Machine/user-specific environment values.
[[ -r "$HOME/.env" ]] && source "$HOME/.env"
