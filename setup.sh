#!/bin/zsh

# DOCUMENTATION_START
#
# - Moves all the custom scripts from the `scripts` dir to a `custom-helper-scripts` directory.
# - Adds code to source all the custom scripts in your ~/.zshrc file, between CUSTOM_SCRIPTS_{START,END} tags
#
# DOCUMENTATION_END

# Define the directory where custom helper scripts will be stored
custom_scripts_dir="$HOME/custom-helper-scripts"

# Create the custom scripts directory if it doesn't exist
mkdir -p "${custom_scripts_dir}"

SCRIPTS_DIR="scripts"
cd ${SCRIPTS_DIR}

# Copy your custom scripts into the custom scripts directory
cp * "${custom_scripts_dir}"

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
echo "# Generated code, do not modify" >> "${TEMP_FILE}"
for script_name in $(ls -1); do
  echo "source ${custom_scripts_dir}/${script_name}" >> "${TEMP_FILE}"
done

# Replace everything between #CUSTOM_SCRIPTS_START and #CUSTOM_SCRIPTS_END with the temp file contents
sed -i.bak -e "/${START_TAG}/r ${TEMP_FILE}" ~/.zshrc

# Source your .zshrc to apply the changes immediately
source ~/.zshrc

rm ${TEMP_FILE}
echo "Custom scripts setup complete."

