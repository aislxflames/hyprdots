
# Extract colors from pywal's ~/.cache/wal/colors file
color1=$(cat ~/.cache/wal/colors | sed -n '1p')
color2=$(cat ~/.cache/wal/colors | sed -n '2p')
color3=$(cat ~/.cache/wal/colors | sed -n '3p')
color4=$(cat ~/.cache/wal/colors | sed -n '4p')
color5=$(cat ~/.cache/wal/colors | sed -n '5p')
color6=$(cat ~/.cache/wal/colors | sed -n '6p')
color7=$(cat ~/.cache/wal/colors | sed -n '7p')
color8=$(cat ~/.cache/wal/colors | sed -n '8p')

# Update CAVA's config file
sed -i "s/gradient_color_1 = .*/gradient_color_1 = '$color1'/" ~/.config/cava/config
sed -i "s/gradient_color_2 = .*/gradient_color_2 = '$color2'/" ~/.config/cava/config
sed -i "s/gradient_color_3 = .*/gradient_color_3 = '$color3'/" ~/.config/cava/config
sed -i "s/gradient_color_4 = .*/gradient_color_4 = '$color4'/" ~/.config/cava/config
sed -i "s/gradient_color_5 = .*/gradient_color_5 = '$color5'/" ~/.config/cava/config
sed -i "s/gradient_color_6 = .*/gradient_color_6 = '$color6'/" ~/.config/cava/config
sed -i "s/gradient_color_7 = .*/gradient_color_7 = '$color7'/" ~/.config/cava/config
sed -i "s/gradient_color_8 = .*/gradient_color_8 = '$color8'/" ~/.config/cava/config

# Restart CAVA to apply the new gradient
pkill cava
cava &
