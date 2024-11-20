#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)

# Remove the "Selected image path: " part from the output, and trim any excess spaces/newlines
WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | sed 's/Selected image path: //' | xargs)

# Debugging: Print the wallpaper path to make sure it's correct
echo "Applying wallpaper: $WALLPAPER_PATH"

# Check if the file exists
if [[ ! -f "$WALLPAPER_PATH" ]]; then
  echo "Error: Wallpaper file does not exist at '$WALLPAPER_PATH'."
  exit 1
fi

# Apply the Pywal color scheme based on the selected wallpaper
wal -i "$WALLPAPER_PATH"
