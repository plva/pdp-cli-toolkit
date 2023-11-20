# DOCUMENTATION_START
#
# - Helpers for fzf utility, including configuration for env vars
#
# DOCUMENTATION_END

export FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git \) -prune -o -print'
alias nf="nvim \$(fzf)"
