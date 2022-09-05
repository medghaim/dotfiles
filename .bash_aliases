#################
# PATHS/EXPORTS #
#################

export PATH=/usr/local/bin:/usr/local/go/bin:~/bin:~/go/bin:$PATH
export GOPATH=~/go
export TERM=xterm-256color
export EDITOR=vim

##########################
# TERMINAL CONFIGURATION #
##########################

bind "set completion-ignore-case on"
stty -ixon #allows forward recursive search

###########
# ALIASES #
###########

alias ..='cd ..'
alias ...='cd ../..'

alias bashrc='vim ~/.bash_aliases && . ~/.bashrc && echo Bash config editted and reloaded.'
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf && tmux source-file ~/.tmux.conf && echo tmux config editted and reloaded.'

alias grep='egrep --color'
alias awk='gawk'

alias py='python3'
alias tmux='tmux -2'
alias copy='xclip -selection c'

##########
# DOCKER #
##########
alias dps='docker container ps --format "table {{.Names}}\\t{{.Status}}"'

########
#  GO  #
########
go_use() {
	local input version
	input=$1
	case $input in
		1.18)
			;;
		1.19)
			;;
		*)
			echo "no go version set up for $input" >&2
			return 1
			;;
	esac

	ln -sf /home/medgh/go/bin/go$input ~/bin/go
}
