#!/bin/bash
# Claude Code tmux tab color notification
# Usage: tmux-notify.sh <green|red|clear|focus>

ACTION="$1"

# focus is called from tmux hook (no TMUX_PANE); others from Claude hooks
if [ "$ACTION" != "focus" ] && [ -z "$TMUX_PANE" ]; then
    exit 0
fi

case "$ACTION" in
    green)
        tmux set-window-option -t "$TMUX_PANE" @claude_notify "green"
        tmux set-window-option -t "$TMUX_PANE" window-status-style "fg=colour255,bg=colour34,bold"
        ;;
    red)
        tmux set-window-option -t "$TMUX_PANE" @claude_notify "red"
        tmux set-window-option -t "$TMUX_PANE" window-status-style "fg=colour232,bg=colour208,bold"
        ;;
    clear)
        tmux set-window-option -t "$TMUX_PANE" -u @claude_notify 2>/dev/null
        tmux set-window-option -t "$TMUX_PANE" -u window-status-style 2>/dev/null
        ;;
    focus)
        # Called by tmux session-window-changed hook
        # Clear green (informational), keep red (needs response)
        STATUS=$(tmux show-window-option -v @claude_notify 2>/dev/null)
        if [ "$STATUS" = "green" ]; then
            tmux set-window-option -u @claude_notify 2>/dev/null
            tmux set-window-option -u window-status-style 2>/dev/null
        fi
        ;;
esac
