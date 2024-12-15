#!/bin/bash

# Get the parent directory of the current working directory
parent_dir=$(dirname "$PWD")

# Export the environment variables using the parent directory path
export NUPLAN_DATA_ROOT="$parent_dir/nuplan/dataset"
export NUPLAN_MAPS_ROOT="$parent_dir/nuplan/dataset/maps"
export NUPLAN_EXP_ROOT="$parent_dir/nuplan/exp"

# Define the current working directory
current_dir=$(pwd)

# Define the new paths based on the current working directory
path_a="$current_dir/nuplan/planning/script/config/common"
path_b="$current_dir/nuplan/planning/script/experiments"

# Path to the YAML file
yaml_file="$current_dir/nuplan/planning/script/config/simulation/default_simulation.yaml"

# Use sed to replace the searchpath values in the YAML file
sed -i '/searchpath:/,/^  - / s/^  - .*//' "$yaml_file"
sed -i '/searchpath:/,/^  - / s/^  - .*//' "$yaml_file"
sed -i "/searchpath:/a \ \ - $path_a\n\ \ - $path_b" "$yaml_file"
sed -i '/searchpath:/,/defaults:/ {/^$/d;}' "$yaml_file"

# Path to the YAML file
yaml_file="$current_dir/nuplan/planning/script/config/nuboard/default_nuboard.yaml"

# Use sed to replace the searchpath values in the YAML file
sed -i '/searchpath:/,/^  - / s/^  - .*//' "$yaml_file"
sed -i '/searchpath:/,/^  - / s/^  - .*//' "$yaml_file"
sed -i "/searchpath:/a \ \ - $path_a\n\ \ - $path_b" "$yaml_file"
sed -i '/searchpath:/,/defaults:/ {/^$/d;}' "$yaml_file"