#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)
WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | sed 's/Selected image path: //')
echo "$WALLPAPER_PATH"