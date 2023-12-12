#!/bin/zsh

# DOCUMENTATION_START
#
# - Moves all the custom scripts from the `scripts` dir to a `custom-helper-scripts` directory.
# - Adds code to source all the custom scripts in your ~/.zshrc file, between CUSTOM_SCRIPTS_{START,END} tags
#
# DOCUMENTATION_END

source setup/setup-git.sh
setup_custom_scripts() {
  # Define the directory where custom helper scripts will be stored
  local custom_scripts_dir="$HOME/custom-helper-scripts"

  # Create the custom scripts directory if it doesn't exist
  mkdir -p "${custom_scripts_dir}"

  SCRIPTS_DIR="scripts"
  cd ${SCRIPTS_DIR}

  # Copy your custom scripts into the custom scripts directory
  find . -maxdepth 1 -type f -exec cp {} "${custom_scripts_dir}" \;

  START_TAG="# CUSTOM_SCRIPTS_START"
  END_TAG="# CUSTOM_SCRIPTS_END"

  # Check if the custom section exists in .zshrc
  if ! grep -q "${START_TAG}" ~/.zshrc; then
    # If it doesn't exist, create it at the end of the file
    echo >> ~/.zshrc
    echo "${START_TAG}" >> ~/.zshrc
    echo "${END_TAG}" >> ~/.zshrc
  else
    # Remove the existing content between ${START_TAG} and ${END_TAG}
    sed -i.bak "/${START_TAG}/,/${END_TAG}/{//!d;}" ~/.zshrc
  fi


  # Save the new custom section to a temporary file
  TEMP_FILE="/tmp/custom_scripts_section.tmp"
  echo "# Generated code, do not modify" > "${TEMP_FILE}"
  CLI_HELPERS_DIR="/Users/paulvasiu/dev/pdp-cli-toolkit"
  PDP_BOOTSTRAP_DIR="/Users/paulvasiu/dev/pdp-bootstrap"

  echo "# \`setup_cli_toolkit\` stands for build" >> "${TEMP_FILE}"
  # echo "source ~/repos/zsh-autocomplete/zsh-autocomplete.plugin.zsh" >> "${TEMP_FILE}"
  echo "alias setup_cli_toolkit=\"cd ${CLI_HELPERS_DIR} && ./setup.sh; cd - && source_zshrc\"" >> "${TEMP_FILE}"
  # ball = build_all
  echo "alias ball=\"cd ${PDP_BOOTSTRAP_DIR} && ./bootstrap.sh; cd - && setup_cli_toolkit\"" >> "${TEMP_FILE}"

  echo 'export PATH="${PATH}:/Users/paulvasiu/Library/Python/3.9/bin/"' >> "${TEMP_FILE}"
  echo 'export PYTHONPATH="${PYTHONPATH}:/Users/paulvasiu/Library/Python/3.9/bin/"' >> "${TEMP_FILE}"
  
  for script_name in $(ls -1 ${custom_scripts_dir}); do
    echo "source ${custom_scripts_dir}/${script_name}" >> "${TEMP_FILE}"
  done

  # setup zoxide (must be done at end of config file"
  echo 'eval "$(zoxide init zsh)"' >> "${TEMP_FILE}"
  # Replace everything between #CUSTOM_SCRIPTS_START and #CUSTOM_SCRIPTS_END with the temp file contents
  sed -i.bak -e "/${START_TAG}/r ${TEMP_FILE}" ~/.zshrc

  # Source your .zshrc to apply the changes immediately
  source ~/.zshrc

  rm ${TEMP_FILE}
  echo "Finished setting up custom scripts."

}
setup_custom_scripts

setup_tmux() {
  cp setup/templates/.tmux.conf ~
}

# Link zshenv to zshrc, so vim loads it
#ln -s ~/.zshrc ~/.zshenv

setup_git_diff_so_fancy() {
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
  git config --global interactive.diffFilter "diff-so-fancy --patch"

  git config --global color.ui true

  git config --global color.diff-highlight.oldNormal    "red bold"
  git config --global color.diff-highlight.oldHighlight "red bold 52"
  git config --global color.diff-highlight.newNormal    "green bold"
  git config --global color.diff-highlight.newHighlight "green bold 22"

  git config --global color.diff.meta       "11"
  git config --global color.diff.frag       "magenta bold"
  git config --global color.diff.func       "146 bold"
  git config --global color.diff.commit     "yellow bold"
  git config --global color.diff.old        "red bold"
  git config --global color.diff.new        "green bold"
  git config --global color.diff.whitespace "red reverse"
}
setup_git_diff_so_fancy

setup_npm_packages() {
  npm install -g tldr
}
setup_npm_packages
