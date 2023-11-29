#alias b="./bootstrap.sh --install-without-asking"

### pdp build helpers
alias s="source ~/.zshrc"


  
### python scripts
alias uniquewords="~/dev/pdp-cli-toolkit/scripts/python/unique_words.py"

### tools
alias n="nvim"
alias t="tree"
alias m="tmux"

### history
alias h="history"
# history -tail
alias ht="history | tail"
alias fht="histor | cut -c 8- | uniquewords | tail -50 | fzf | pbcopy"
alias fh="history | cut -c 8- | uniquewords | fzf | pbcopy"

### git
alias gs="git status"
alias gas="gita super"
alias gasd="gita super diff --color"
alias gasds="gita super diff --staged --color"


### tmux
alias ta="tmux attach"
alias mux="tmuxinator"

