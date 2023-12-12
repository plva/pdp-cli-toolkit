#alias b="./bootstrap.sh --install-without-asking"

### pdp build helpers
alias s="source ~/.zshrc"
alias source_zshrc="source ~/.zshrc"

### python scripts
alias uniquewords="~/dev/pdp-cli-toolkit/scripts/python/unique_words.py"

### tools
alias n="nvim"
alias b="bat"
alias t="tree -I 'node_modules'"
# tree no report/formatting
alias tn="t --noreport -i -f"
# tree no report/formatting, files only, stripping out "*" from executable files
alias tnf='tn -F | grep -vE ".*\/$" | sed "s/\*$//"'
#### npm
alias nrs="npm run start"
# -s means silent
alias m="clear && tmux clear-history && nrs -s"
# call m with jq
alias mq="clear && tmux clear-history && m | jq"
alias q="clear && tmux clear-history && m | jq"

### history
alias h="history"
# history -tail
alias ht="history | tail"
alias fht="histor | cut -c 8- | uniquewords | tail -50 | fzf | pbcopy"
alias fh="history | cut -c 8- | uniquewords | fzf | pbcopy"

### git
alias gs="git status --short --branch --show-stash"
alias ggd="git difftool"
alias ggds="git difftool --staged"
unalias glog
alias glog='git log --oneline --decorate --graph --format="%C(auto)%h %C(green)|%C(auto) %<(12)%ad%C(green)|%C(auto) %s%d %C(reset)" --date=relative'
alias glogs="glog --stat"
alias gas="gita super"
alias gasd="gita super diff --color"
alias gasds="gita super diff --staged --color"


### tmux
alias ta="tmux attach"
alias mux="tmuxinator"

### helper functions
# short date 
alias sd="date +%Y-%m-%d"

