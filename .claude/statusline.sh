#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Get current directory basename
workdir=$(basename "$dir")

# Get git branch if in a git repo
branch=""
if [ -d "$dir/.git" ] || git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(cd "$dir" 2>/dev/null && git -c core.fileMode=false rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

# Build GitHub URL from remote
branch_part=""
if [ -n "$branch" ]; then
    remote_url=$(cd "$dir" 2>/dev/null && git remote get-url upstream 2>/dev/null || git remote get-url origin 2>/dev/null)
    if [ -n "$remote_url" ]; then
        repo_url=$(echo "$remote_url" | sed 's|git@github.com:|https://github.com/|' | sed 's|\.git$||')
        branch_url="${repo_url}/tree/${branch}"
        branch_part=" (\e]8;;${branch_url}\e\\\\\e[0;33m${branch}\e[0m\e]8;;\e\\\\)"
    else
        branch_part=" (\e[0;33m${branch}\e[0m)"
    fi
fi

# Context percentage (without progress bar)
context_part=""
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$context_used" ]; then
    context_int=$(printf "%.0f" "$context_used")
    context_part=" \e[2m${context_int}%\e[0m"
else
    context_part=" \e[2mN/A\e[0m"
fi

# Single printf '%b' for the whole line so OSC 8 escapes work
printf '%b' "\e[0;34m${workdir}\e[0m${branch_part}${context_part}\n"
