# ~/.zshrc
# Keep this file intentionally small. Individual concerns live in ~/.config/zsh/.

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

for config in \
  env \
  history \
  plugins \
  completion \
  aliases \
  tools \
  prompt
do
  [[ -r "$ZSH_CONFIG_DIR/$config.zsh" ]] && source "$ZSH_CONFIG_DIR/$config.zsh"
done

unset config
