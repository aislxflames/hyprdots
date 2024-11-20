#!/bin/bash

# Run Waypaper to select a wallpaper (this will return the selected wallpaper path)
WALLPAPER_PATH=$(waypaper)
echo "PATH FOUND $WALLPAPER_PATH"
wal -i "$WALLPAPER_PATH"
