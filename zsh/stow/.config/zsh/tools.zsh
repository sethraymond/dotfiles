# Shell integrations and language/tool managers
# Nothing in this file should install or update software.

# fzf
[[ -r "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Pipenv
if (( $+commands[pipenv] )); then
  eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
  export PIPENV_VENV_IN_PROJECT=1
fi

# 1Password CLI
if (( $+commands[op] )); then
  eval "$(op completion zsh)"
  compdef _op op
  [[ -r "$HOME/.config/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"
fi

# NVM
if [[ -d /usr/local/share/nvm ]]; then
  export NVM_DIR="/usr/local/share/nvm"
else
  export NVM_DIR="$HOME/.nvm"
fi

# Preserve your current behavior by loading NVM eagerly. If startup time becomes
# noticeable, this is a good candidate for lazy-loading later.
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# Do not source NVM's bash_completion in zsh.

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && path=("$PYENV_ROOT/bin" $path)

if (( $+commands[pyenv] )); then
  eval "$(pyenv init - zsh)"
fi
