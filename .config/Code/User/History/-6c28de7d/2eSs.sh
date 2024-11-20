#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)

# Check if Waypaper returned a path (i.e., the user selected a wallpaper)
if [[ -z "$WALLPAPER_PATH" ]]; then
  echo "No wallpaper selected."
  exit 1
fi

# Display the selected wallpaper path
echo "Selected image path: $WALLPAPER_PATH"

# Apply the Pywal color scheme based on the selected wallpaper
