# Zinit and plugins
#
# This file intentionally does not install Zinit. Install/bootstrap tools outside
# interactive shell startup, then this file will load them when available.

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ -r "$ZINIT_HOME/zinit.zsh" ]]; then
  source "$ZINIT_HOME/zinit.zsh"

  # zsh-autoenv configuration must be set before loading the plugin.
  AUTOENV_FILE_ENTER=.autoenv.zsh
  AUTOENV_FILE_LEAVE=.autoenv.zsh

  zinit ice wait lucid
  zinit light zsh-users/zsh-syntax-highlighting

  zinit ice wait lucid
  zinit light zsh-users/zsh-completions

  zinit ice wait lucid
  zinit light zsh-users/zsh-autosuggestions

  zinit ice wait lucid
  zinit light Aloxaf/fzf-tab

  zinit ice wait lucid
  zinit light Tarrasch/zsh-autoenv

  zinit snippet OMZP::git
  zinit snippet OMZP::sudo
  zinit snippet OMZP::command-not-found
fi
