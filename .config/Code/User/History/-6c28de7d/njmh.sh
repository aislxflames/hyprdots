#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)
echo "$WALLPAPER_PATH"
# Remove any unnecessary text or prefixes (if any) and clean up the output
WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | sed 's/Selected image path: /home/aislx/ //' | xargs)
WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | sed 's/ Sent command to set wallpaper was set with swww//')

# Debugging: Print the wallpaper path to make sure it's correct
echo "$WALLPAPER_PATH"