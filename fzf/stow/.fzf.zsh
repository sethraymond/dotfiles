# Setup fzf
# ---------

if (( $+commands[fzf] )); then
  if fzf_zsh="$(fzf --zsh 2>/dev/null)"; then
    source <(print -r -- "$fzf_zsh")
  else
    for fzf_file in \
      /usr/share/fzf/completion.zsh \
      /usr/share/doc/fzf/examples/completion.zsh
    do
      if [[ -r "$fzf_file" ]]; then
        source "$fzf_file"
        break
      fi
    done

    for fzf_file in \
      /usr/share/fzf/key-bindings.zsh \
      /usr/share/doc/fzf/examples/key-bindings.zsh
    do
      if [[ -r "$fzf_file" ]]; then
        source "$fzf_file"
        break
      fi
    done
  fi
fi

unset fzf_file fzf_zsh
