#################
# PATHS/EXPORTS #
#################

export PATH=~/bin:$PATH:/usr/local/go/bin:~/.local/bin:~/.poetry/bin
export GOPATH=~/go
export TERM=xterm-256color
export EDITOR=vim
export FZF_DEFAULT_OPTS='--height 20% --reverse --border'

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

alias gpr='git pull --rebase upstream'

alias dps='docker container ps --format "table {{.Names}}\\t{{.Status}}"'

alias dfind='find . -type d -name'
alias ffind='find . -type f -name'

alias vf='vim $(fzf)'
alias cf='cd $(find . -type d -print | fzf)'

alias crep='grep --exclude=\*.json --exclude=\*.sql --exclude=\*.pyc --exclude=\*.js'

#########
#  GIT  #
#########

grfix() {
    # Check if a commit SHA is provided as the first parameter
    if [ -z "$1" ]; then
        echo "Error: Commit SHA is required." >&2
        return 1 # Exit with error
    fi

    # Extract the commit SHA from the first parameter
    local commitSHA="$1"

    # Execute the git rebase command with --autosquash option
    git rebase -i --autosquash "${commitSHA}~1"
}

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

	ln -sf /home/moody/go/bin/go$input ~/bin/go
}
