#################
# PATHS/EXPORTS #
#################

export PATH=$PATH:/usr/local/go/bin:~/.poetry/bin:~/.local/bin
export GOPATH=~/go
export TERM=screen-256color
export EDITOR=vim
export CDPATH=':/home/moody/work/teamlumos:/home/moody/work/teamlumos/lumos/backend/python:/home/moody/work/teamlumos/lumos/backend/python/services'
export FZF_DEFAULT_OPTS='--height 20% --reverse --border'

#########
# AGENT #
#########

# Allows Claude access to LSP plugins
export ENABLE_LSP_TOOL=1


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

alias vim='nvim'

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
#alias cf='cd $(find . /home/moody/work/teamlumos/lumos -type d -print | fzf)'
alias cf='cd $(find . /home/moody/work/teamlumos/lumos -type d -not -path "*/\.*" -not -path "*/__pycache__*" -not -path "*/.mypy_cache*" -not -path "*/node_modules*" -print | fzf)'

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
