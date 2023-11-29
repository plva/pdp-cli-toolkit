#!/bin/zsh
cd ~/dev
directories=($(ls -d */))

# Create a temporary directory to store output files
output_dir=$(mktemp -d)

for dir in "${directories[@]}"; do
  output_file="$output_dir/git_status_${dir%/}.txt"
  (
    touch "${output_file}"
    cd "$dir"
    script -q /dev/null git status > ${output_file}
  ) &

  # Store the background job's PID in the jobs array
  jobs+=($!)
done

# Wait for all background jobs to finish
for job in "${jobs[@]}"; do
  wait "$job"
done

# Display the saved output files with preserved colors
for dir in "${directories[@]}"; do
  output_file="$output_dir/git_status_${dir%/}.txt"
  pb
  echo "Git status in directory: $dir"
  cat "$output_file"
  echo
done

# Clean up temporary directory
rm -rf "$output_dir"
cd -
