ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zinit cdreplay -q

HISTSIZE=5000
HIST_STAMPS="%a, %d %b %Y - %T"
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

export MANPATH="/usr/local/man:$MANPATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ -d "/usr/local/go/bin" ] ; then
    export PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
    export PATH="$HOME/go/bin:$PATH"
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"

# Preferred editor
export EDITOR='vim'

# Custom aliases
source $HOME/.aliases
if [ -f $HOME/.env ]; then
  source $HOME/.env
fi

# Shell integrations
# Can't just check fzf command because sourcing .fzf.zsh is what provides the command!
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
source ~/.fzf.zsh

if ! command -v zoxide &> /dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi
eval "$(zoxide init --cmd cd zsh)"

if command -v bat &> /dev/null; then
  export BAT_THEME="ansi"
  alias cat="bat"
else
  echo "Missing bat - install with package manager, then mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat"
fi

if ! command -v oh-my-posh &> /dev/null; then
  OH_MY_POSH_INSTALL_DIR="${HOME}/.local/bin/oh-my-posh"
  [ ! -d $OH_MY_POSH_INSTALL_DIR ] && mkdir -p "$(dirname $OH_MY_POSH_INSTALL_DIR)"
  curl -s https://ohmyposh/install.sh | bash -s -- -d $OH_MY_POSH_INSTALL_DIR
fi

if ! command -v lazygit &> /dev/null && command -v go &> /dev/null; then
  go install github.com/jesseduffield/lazygit@latest
fi

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/oh-my-posh.toml)"
