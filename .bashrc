# ~/.bashrc

#functions required for getting git branch for updating terminal prompt
#get the current command before execution
function precommand() {

	if [ -z "$AT_PROMPT" ]; then
		return
	fi
	unset AT_PROMPT
	arr=($BASH_COMMAND)

}
trap "precommand" DEBUG

#check to see if command is a git command - if so, check current branch name
FIRST_PROMPT=1
function postcommand() {

	AT_PROMPT=1

	if [ -n "$FIRST_PROMPT" ]; then
		unset FIRST_PROMPT
		return
	fi

	if [ -n "$arr" ]; then
		if [ "${arr[0]}" == "git" ]; then
			checkgitdir;
		fi
	fi

}
PROMPT_COMMAND="postcommand"

#edit prompt and display current branch if in a git repository
#current formatting:
# retval user@host - time : current directory [optional: checked out branch] $
function checkgitdir() {
	git -C $PWD rev-parse > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		PS1="\$? \[\e[32m\]\u \[\e[37m\]\t\[\e[m\] : \[\e[33m\]\w \e[1;36m\](`git rev-parse --abbrev-ref HEAD`) \e[0;33m\]\$\[\e[m\] "
	else
		PS1="\$? \[\e[32m\]\u \[\e[37m\]\t\[\e[m\] : \[\e[33m\]\w \$\[\e[m\] "
	fi
}

function cd() { builtin cd "$@" && checkgitdir; }

# The rest is mostly cut from the ~/.bashrc that comes with Ubuntu
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
if [ -z "$debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	checkgitdir;
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

cd ~
