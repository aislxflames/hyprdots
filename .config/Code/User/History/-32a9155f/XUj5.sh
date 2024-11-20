#!/bin/bash

# Generate pywal color palette (if not already generated)
# Extract colors from pywal's ~/.cache/wal/colors file
color0=$(cat ~/.cache/wal/colors | grep "color0" | awk '{print $3}')
color1=$(cat ~/.cache/wal/colors | grep "color1" | awk '{print $3}')
color2=$(cat ~/.cache/wal/colors | grep "color2" | awk '{print $3}')
color3=$(cat ~/.cache/wal/colors | grep "color3" | awk '{print $3}')
color4=$(cat ~/.cache/wal/colors | grep "color4" | awk '{print $3}')
color5=$(cat ~/.cache/wal/colors | grep "color5" | awk '{print $3}')
color6=$(cat ~/.cache/wal/colors | grep "color6" | awk '{print $3}')
color7=$(cat ~/.cache/wal/colors | grep "color7" | awk '{print $3}')
# Update CAVA's config file
sed -i "s/gradient_color_1 = .*/gradient_color_1 = '$color0'/" ~/.config/cava/config
sed -i "s/gradient_color_2 = .*/gradient_color_2 = '$color1'/" ~/.config/cava/config
sed -i "s/gradient_color_3 = .*/gradient_color_3 = '$color2'/" ~/.config/cava/config
sed -i "s/gradient_color_4 = .*/gradient_color_4 = '$color3'/" ~/.config/cava/config
sed -i "s/gradient_color_5 = .*/gradient_color_5 = '$color4'/" ~/.config/cava/config
sed -i "s/gradient_color_6 = .*/gradient_color_6 = '$color5'/" ~/.config/cava/config
sed -i "s/gradient_color_7 = .*/gradient_color_7 = '$color6'/" ~/.config/cava/config
sed -i "s/gradient_color_8 = .*/gradient_color_8 = '$color7'/" ~/.config/cava/config
# Restart CAVA to apply the new gradient
pkill cava
cava &