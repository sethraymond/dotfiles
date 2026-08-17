# Prompt
# Keep prompt initialization last so it sees the final shell environment.

oh_my_posh="${commands[oh-my-posh]:-}"

if [[ -n "$oh_my_posh" && -x "$oh_my_posh" && ! -d "$oh_my_posh" ]]; then
  eval "$("$oh_my_posh" init zsh --config "$HOME/.config/ohmyposh/oh-my-posh.toml")"
fi

unset oh_my_posh
