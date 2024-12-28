#!/bin/bash

# Directory to pick a random folder from
BASE_DIR="/home/manish/Wallpapers"

# Check if the base directory exists
if [[ ! -d "$BASE_DIR" ]]; then
    echo "The directory '$BASE_DIR' does not exist."
    exit 1
fi

# Get a list of subdirectories
folders=("$BASE_DIR"/*/)

# Check if there are any folders
if [[ ${#folders[@]} -eq 0 ]]; then
    echo "No folders found in '$BASE_DIR'."
    exit 1
fi

# Count the number of folders
folder_count=${#folders[@]}

# Generate a random index based on the folder count
random_index=$(shuf -i 0-$(($folder_count - 1)) -n 1)

# Select the random folder
random_folder=${folders[$random_index]}
echo "Random folder selected: $random_folder"

# Find image files (jpg, png, gif) in the selected folder
image_files=("$random_folder"*.{jpg,png,gif})

# Check if any image files exist in the folder
if [[ ${#image_files[@]} -eq 0 ]]; then
    echo "No image files found in the folder '$random_folder'."
    exit 1
fi

# Count the number of image files
image_count=${#image_files[@]}

# Generate a random index for the image
random_image_index=$(shuf -i 0-$(($image_count - 1)) -n 1)

# Select the random image
random_image=${image_files[$random_image_index]}
echo "Random image selected: $random_image"

# Set the image via Simple Wayland Wallpaper Compositor and generate wal colors
swww img "$random_image" && wal -i "$random_image"

# Path to hyprlock configuration
HYPRLOCK_CONFIG=~/.config/hypr/hyprlock.conf
WAL_COLORS=~/.cache/wal/colors

# Extract color1 from wal colors (or any other color you want, e.g., color0, color2)
wal_color=$(sed -n '2p' "$WAL_COLORS") # color1 is on line 2, adjust as necessary

# Use sed to replace the background path in hyprlock.conf with the selected image path
sed -i "s|path = .*|path = $random_image|" "$HYPRLOCK_CONFIG"

# Use sed to replace the color in the label section ONLY
sed -i "/label {/,/}/s|color = .*|color = rgba($wal_color, 1.0)|" "$HYPRLOCK_CONFIG"

# Optionally, reload hyprlock
pkill -USR1 hyprlock || echo "Failed to reload hyprlock. Restart manually."

