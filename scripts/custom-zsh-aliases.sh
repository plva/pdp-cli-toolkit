#alias b="./bootstrap.sh --install-without-asking"

### pdp build helpers
alias s="source ~/.zshrc"

### commands
alias c="clear"

### tools
alias n="nvim"
alias t="tree"
alias m="tmux"

### history
alias h="history"
# history -tail
alias ht="history -50 | tail"
alias fht="history -50 | cut -c 8- | tail -50 | fzf | pbcopy"

### git
alias gs="git status"
alias gas="gita super"
alias gasd="gita super diff --color"
alias gasds="gita super diff --staged --color"


### tmux
alias ta="tmux attach"
