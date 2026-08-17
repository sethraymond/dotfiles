# Aliases

[[ -r "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -r "$HOME/.work_aliases" ]] && source "$HOME/.work_aliases"

if (( $+commands[bat] )); then
  export BAT_THEME="ansi"
  alias cat="bat"
fi
