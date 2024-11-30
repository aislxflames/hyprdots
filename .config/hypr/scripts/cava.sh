#!/bin/bash

# Path to the wal colors file
COLORS_FILE="$HOME/.cache/wal/colors"

# Path to the CAVA config file
CAVA_CONFIG="$HOME/.config/cava/config"

# Function to update CAVA with the new colors
update_cava_colors() {
  # Extract colors from the colors file
  color1=$(sed -n '1p' "$COLORS_FILE")
  color2=$(sed -n '2p' "$COLORS_FILE")
  color3=$(sed -n '3p' "$COLORS_FILE")
  color4=$(sed -n '4p' "$COLORS_FILE")
  color5=$(sed -n '5p' "$COLORS_FILE")
  color6=$(sed -n '6p' "$COLORS_FILE")
  color7=$(sed -n '7p' "$COLORS_FILE")
  color8=$(sed -n '8p' "$COLORS_FILE")

  # Update the CAVA config with the new colors
  sed -i "s/gradient_color_1 = .*/gradient_color_1 = '$color1'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_2 = .*/gradient_color_2 = '$color2'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_3 = .*/gradient_color_3 = '$color3'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_4 = .*/gradient_color_4 = '$color4'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_5 = .*/gradient_color_5 = '$color5'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_6 = .*/gradient_color_6 = '$color6'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_7 = .*/gradient_color_7 = '$color7'/" "$CAVA_CONFIG"
  sed -i "s/gradient_color_8 = .*/gradient_color_8 = '$color8'/" "$CAVA_CONFIG"

  # Kill all running instances of cava
  pkill cava

  # Find all TTYs where cava was running and restart cava in those terminals
  for tty in $(ps aux | grep '[c]ava' | awk '{print $7}' | sort -u); do
    if [ -n "$tty" ]; then
      # Send the cava start command to each terminal's TTY
      echo "Starting cava in $tty"
      ttyname=$(ps -p $$ -o tty=)
      if [ "$ttyname" == "$tty" ]; then
        # This is the terminal we are running in, start cava in the current terminal
        cava &
      else
        # Otherwise, send the start command to the specified tty
        screen -S cava-session -X stuff "cava\n"
        # You can use `tmux` or `tty` for other approaches depending on how you manage terminals.
      fi
    fi
  done
}

# Monitor the colors file for changes
inotifywait -m -e close_write "$COLORS_FILE" | while read path action file; do
  update_cava_colors
done
