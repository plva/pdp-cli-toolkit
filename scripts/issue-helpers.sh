# DOCUMENTATION_START
#
# - Helpers for managing todos, until we have a service that can keep track of these
#
# DOCUMENTATION_END

# todo: get this dynamically from `~/dev`
DEV_DIR="/Users/paulvasiu/dev"

# FUNCTION_DOCUMENTATION_START
# - Gets all the todos from pdp project root directory
# FUNCTION_DOCUMENTATION_END
pdp_get_from_pdp_project_root() {
 # local patterns="todo:.*\|todo_[0-9]*:.*"
  local patterns="^[^[:alnum:]]*todo:.*"
  
  echo "Todos from project files:"
  # Use find to search for files, excluding .git and node_modules directories
  find ${DEV_DIR} -type f -not \( -path "**/.git/*" -o -path "**/node_modules/*" \) -exec grep -E -H -n "$patterns" {} \; | sed 's/:\([^:]*\):\(.*\)/:\1\n  \2/' | sed 's/^/    /'

  echo "Todos from todo.md:"
  glow ${DEV_DIR}/todo.md
}


# FUNCTION_DOCUMENTATION_START
# - Gets all the todos from current directory
# FUNCTION_DOCUMENTATION_END
pdp_get_todos_from_current_dir() {
 # local patterns="todo:.*\|todo_[0-9]*:.*"
  local patterns="^[^[:alnum:]]*todo:.*"
  
  echo "Todos from project files:"
  # Use find to search for files, excluding .git and node_modules directories
  find . -type f -not \( -path "**/.git/*" -o -path "**/node_modules/*" \) -exec grep -E -H -n "$patterns" {} \; | sed 's/:\([^:]*\):\(.*\)/:\1\n  \2/' | sed 's/^/    /'

  echo "Todos from todo.md files:"
  find . -type f -name "todo.md" -print -exec glow {} \;
 # find . -type f -name "todo.md" -exec glow {} \;
}
