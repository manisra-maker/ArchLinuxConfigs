#!/bin/bash

BASE_DIR="$HOME/Wallpapers"
CHOSEN_FILE="/tmp/ranger_wallpaper_choice"

HYPRLOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"
WAL_COLORS="$HOME/.cache/wal/colors"

# Safety checks
[[ ! -d "$BASE_DIR" ]] && echo "❌ Wallpapers directory not found" && exit 1

# Clean old choice
rm -f "$CHOSEN_FILE"

# Open ranger and let user choose a file
ranger --choosefile="$CHOSEN_FILE" "$BASE_DIR"

# If user quit without selecting
[[ ! -f "$CHOSEN_FILE" ]] && echo "❌ No file selected" && exit 1

# Read selected image
selected_image=$(cat "$CHOSEN_FILE")

# Validate file
[[ ! -f "$selected_image" ]] && echo "❌ Invalid selection" && exit 1

echo "✅ Selected wallpaper: $selected_image"

# Set wallpaper and generate colors
swww img --resize fit "$selected_image" || exit 1
wal -i "$selected_image" || exit 1

# Extract wal color1 (line 2)
wal_color=$(sed -n '2p' "$WAL_COLORS")

# Update hyprlock background path
sed -i "s|path = .*|path = $selected_image|" "$HYPRLOCK_CONFIG"

# Update ONLY label color block
sed -i "/label {/,/}/s|color = .*|color = rgba($wal_color, 1.0)|" "$HYPRLOCK_CONFIG"

# Reload hyprlock
pkill -USR1 hyprlock || echo "⚠️ Restart hyprlock manually"

echo "🎉 Wallpaper & lockscreen updated successfully"
