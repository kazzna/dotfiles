# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

## Configs added by me...

# load library function
function loadlib() {
	lib=${1:?"Must specify the library file..."}
	if [[ -f "$lib" ]]; then
		source "$lib"
	fi
}
ZDIR=$(dirname $(readlink -f ${(%):-%N}))/zsh

# make less more friendly for non-text input files, see lesspipe(1)
if [[ -x /usr/bin/lesspipe ]]; then
	eval "$(SHELL=/bin/sh lesspipe)"
fi

# aliases
if [[ -x /usr/bin/dircolors ]]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi

alias nicely='nice -n19 ionice -c3'

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space

# Color settings
autoload colors
colors
local p_info="%n@%m${WINDOW:+"[$WINDOW]"}"
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
PROMPT="$p_info $p_cdir$p_mark "

# python settings
loadlib "${ZDIR}/python.zshrc"

# nvm settings
loadlib "${ZDIR}/nvm.zshrc"
