#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)
sed 's/Selected image path: '
echo "$WALLPAPER_PATH"
