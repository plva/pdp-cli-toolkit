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
