ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

AUTOENV_FILE_ENTER=.autoenv.zsh
AUTOENV_FILE_LEAVE=.autoenv.zsh

zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light Aloxaf/fzf-tab
zinit ice wait lucid; zinit light Tarrasch/zsh-autoenv

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

fpath+=~/.zfunc
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
if [ -f $HOME/.work_aliases ]; then
  source $HOME/.work_aliases
fi
if [ -f $HOME/.env ]; then
  source $HOME/.env
fi

# Shell integrations
if [ ! -d ${HOME}/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf > /dev/null 2>&1
  ${HOME}/.fzf/install --no-update-rc --no-key-bindings --no-completion --no-bash --no-zsh --no-fish > /dev/null 2>&1
fi
source ${HOME}/.fzf.zsh

if ! command -v zoxide &> /dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh > /dev/null 2>&1
fi
eval "$(zoxide init --cmd cd zsh)"

if command -v bat &> /dev/null; then
  export BAT_THEME="ansi"
  alias cat="bat"
else
  echo "Missing bat - install with package manager, then mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat"
fi

OH_MY_POSH_INSTALL_DIR="${HOME}/.local/bin/oh-my-posh"
export PATH=$PATH:$OH_MY_POSH_INSTALL_DIR
if [ ! -d "$OH_MY_POSH_INSTALL_DIR" ]; then
  mkdir -p ${OH_MY_POSH_INSTALL_DIR}
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $OH_MY_POSH_INSTALL_DIR > /dev/null 2>&1
fi

if ! command -v lazygit &> /dev/null && command -v go &> /dev/null; then
  go install github.com/jesseduffield/lazygit@latest
fi

if command -v pipenv &> /dev/null; then
  eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
  export PIPENV_VENV_IN_PROJECT=1
fi

if command -v op &> /dev/null; then
  eval "$(op completion zsh)"; compdef _op op
fi

if [ -d "/usr/local/share/nvm" ]; then
  NVM_DIR="/usr/local/share/nvm"
else
  NVM_DIR="${HOME}/.nvm"
fi
export NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -d "/opt/forticlient" ]; then
  export PATH="$PATH:/opt/forticlient"
fi

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/oh-my-posh.toml)"
