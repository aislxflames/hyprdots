#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)

# Clean up the output by removing any extra text or unwanted characters
WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | sed 's/Selected image path: //g' | xargs)

# Debugging: Print the wallpaper path to make sure it's correct
echo "Wallpaper path: '$WALLPAPER_PATH'"

# Check if Waypaper returned a path (i.e., the user selected a wallpaper)
if [[ -z "$WALLPAPER_PATH" ]]; then
  echo "No wallpaper selected."
  exit 1
fi

# Check if the wallpaper file exists
if [[ ! -f "$WALLPAPER_PATH" ]]; then
  echo "Error: Wallpaper file does not exist at '$WALLPAPER_PATH'."
  exit 1
fi

# Apply the Pywal color scheme based on the selected wallpaper
wal -i "$WALLPAPER_PATH"

echo "Wallpaper path applied to Pywal."
