# DOCUMENTATION_START
#
# - Helpers for code generation templates
#
# DOCUMENTATION_END

# FUNCTION_DOCUMENTATION_START
# - searches code generation template variables by individual usage with file info
# FUNCTION_DOCUMENTATION_END
search_g_vars_files() {
  grep -oER 'G_[rd]_[A-Za-z0-9_]+' .
}


# FUNCTION_DOCUMENTATION_START
# - find all variables used for code generation
# FUNCTION_DOCUMENTATION_END
search_g_vars() {
  grep -oERh 'G_[rd]_[A-Za-z0-9_]+' . | cat | sort | uniq
}
