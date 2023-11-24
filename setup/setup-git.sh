#!/bin/zsh

# DOCUMENTATION_START
#
# - Sets up git repos as needed for config files
#
# DOCUMENTATION_END

setup_git_repo() {
  local base_dir=$1

  local current_dir=$(pwd)
  cd "${base_dir}"
  if [ -d .git ]; then
    echo "The dir ${base_dir} contains a Git repository."
  else
    echo "This folder does not contain a Git repository. Creating a git repo"
    git init
    
    cp ${current_dir}/setup/templates/.gitignore .
    git add --all
    git commit -m "Initial commit"
  fi
  cd -
}

setup_git_repo ~
