# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# bash history
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="ls:bg:fg:history"
shopt -s histappend
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='rgrep --color=auto'
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function parse_git_dirty {
  [[ ! -z "$(git status --porcelain 2>/dev/null)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)] /"
}

NONE="\[\033[0m\]"
RED="\[\033[31m\]"
YELLOW="\[\033[33m\]"
BLUE="\[\033[34m\]"
CYAN="\[\033[36m\]"

export PS1="${CYAN}\$(date +%H:%M) ${RED}\$(parse_git_branch)${YELLOW}\w ${NONE}$ "

SET_TITLE='\e]0;'
END_TITLE='\007'
PROMPT_COMMAND='echo -ne "${SET_TITLE}${PWD/$HOME/~}${END_TITLE}"'
trap '[ "${BASH_COMMAND:0:2}" != "_z" ] && echo -ne "${SET_TITLE}${BASH_COMMAND}${END_TITLE}"' DEBUG

if which keychain >/dev/null; then
    keychain --quiet
    source ${HOME}/.keychain/${HOSTNAME}-sh
fi

alias ".."="cd .."

. $(homesick show_path)/z/z.sh

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

