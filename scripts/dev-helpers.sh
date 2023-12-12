# DOCUMENTATION_START
#
# - Helpers for the UNIX-based platform-development-platform (environment).
# - Keeps track of repos and changes in them, and wraps API calls as needed
#
# DOCUMENTATION_END

# todo: get this dynamically from `~/dev`
DEV_DIR="/Users/paulvasiu/dev"
PROJECT_CONFIG="project-config.json"
PROJECT_CONFIG_PATH=${DEV_DIR}/${PROJECT_CONFIG}

# FUNCTION_DOCUMENTATION_START
# - Adds a repo to the project config
# todo: Be able to change projects and project configs
# FUNCTION_DOCUMENTATION_END
pdp_add_repo_to_project_config() {
  local directory="$1"
  local config_file="${PROJECT_CONFIG_PATH}"

  # Check if the config file exists
  if [ ! -f "$config_file" ]; then
    echo "Error: $config_file does not exist."
    return 1
  fi

  # Append the full path of the directory to "repos"
  local full_path="$(realpath "$directory")"
  local is_repo_duplicate=$(jq --arg path "$full_path" '.repos | index($path)' "$config_file")
  if [ "$is_repo_duplicate" != "null" ]; then
    echo "$full_path is already in the 'repos' array in $config_file"
  else
    jq --arg path "$full_path" '.repos += [$path]' "$config_file" > "$config_file.tmp" && mv "$config_file.tmp" "$config_file"
    echo "Added $full_path to the 'repos' array in $config_file"
  fi
}

# FUNCTION_DOCUMENTATION_START
# - Get the current pdp project configuration 
# todo: create a better view and options for this 
# FUNCTION_DOCUMENTATION_END
pdp_get_project_config() {
  cat ${PROJECT_CONFIG_PATH} | jq
}

# FUNCTION_DOCUMENTATION_START
# - Get the project git status (as well as git log) for all repos in the current pdp project config
# FUNCTION_DOCUMENTATION_END
pdp_get_project_git_status() {
  pdp_get_project_config | jq '.repos[]' | xargs -I {} zsh -ic 'echo "\n\nIN {}\n" && cd {} && gst && glog | cat'
}

# FUNCTION_DOCUMENTATION_START
# - Commits all the repos with the same commit message
# FUNCTION_DOCUMENTATION_END
pdp_commit_all_with_message() {
  local commit_message=$1
  pdp_get_project_config| jq '.repos[]' | xargs -I {} zsh -ic "echo \"\n\nIN {}\n\" && cd {} && gaa && gc -m \"${commit_message}\""\n
}  

# FUNCTION_DOCUMENTATION_START
# - clears both zsh and tmux history
# FUNCTION_DOCUMENTATION_END
c() {
    clear
    tmux clear-history
}

# FUNCTION_DOCUMENTATION_START
# - cd with grep (globbing)
# - if more than one pattern matches, use fzf to select
# FUNCTION_DOCUMENTATION_END
cg() {
  local pattern="$1"
  local matching_dirs=( *"$pattern"*/ )  # Use () to create an array

  if [ ${#matching_dirs[@]} -eq 1 ]; then
    cd "${matching_dirs[1]}"
    return 0
  elif [ ${#matching_dirs[@]} -gt 1 ]; then
    local selected_dir=$(printf '%s\n' "${matching_dirs[@]}" | fzf)
    cd "${selected_dir}"
    return 0
  else
    echo "No matching directory found for '$pattern'"
    return 1
  fi
}

# FUNCTION_DOCUMENTATION_START
# - Search for files in the current directory with fzf
# - Use bat to display the selected file's content
# FUNCTION_DOCUMENTATION_END
bg() {
  # clear the screen
  c
  local pattern="$1"
  local end_pattern=*"$pattern"* 
  echo "$end_pattern"
  local matching_files=( *"$pattern"* )  # Use () to create an array
  echo "matching files: $matching_files"
  if [ ${#matching_files[@]} -eq 1 ]; then
    bat --paging=never "${matching_files[1]}"
    return 0
  elif [ ${#matching_files[@]} -lt 6 ]; then
    for selected_file in "${matching_files[@]}"; do
      if [ -n "$selected_file" ]; then
        bat --paging=never "$selected_file"
      fi
    done
    return 0
  else
    local selected_file=$(printf '%s\n' "${matching_files[@]}" | fzf)
    if [ -n "$selected_file" ]; then
      bat --paging=never "$selected_file"
      return 0
    else
      echo "No file selected."
      return 1
    fi
  fi
}

# FUNCTION_DOCUMENTATION_START
# - a stands for api
# - curl localhost (or my, as defined in etc hosts)
# FUNCTION_DOCUMENTATION_END
a() {
   local address="$1"
   local json_string="$2"
   # curl --silent my/"${address}"
   curl --silent -X POST -H 'Content-Type: text/plain' -d "${json_string}" my/"${address}"
}

print_color() {
    local text="$1"
    # 179 is yellowish
    local color="179"
    print -P -- "%F{${color}}${text}%f"
}
print_bar() {
    # 179 is yellowish
    local color="179"
    print -P -- "%F{${color}}----------------------------------------------------------------------------------------------------%f"
}
alias pb="print_bar"

