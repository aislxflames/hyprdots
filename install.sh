#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Display script heading
echo "==================================================="
echo "      ███████╗██╗      █████╗ ███╗   ███╗███████╗   "
echo "      ██╔════╝██║     ██╔══██╗████╗ ████║██╔════╝   "
echo "      █████╗  ██║     ███████║██╔████╔██║█████╗     "
echo "      ██╔══╝  ██║     ██╔══██║██║╚██╔╝██║██╔══╝     "
echo "      ██║     ███████╗██║  ██║██║ ╚═╝ ██║███████╗   "
echo "      ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝   "
echo "            Welcome to FlamEs Hyprdots!            "
echo "                FlamEs Dots Setup                  "
echo "                Author: Aislx FlamEs                "
echo "==================================================="
echo

# List of packages to install
packages=(
    hyprland
    waybar
    waypaper
    thunar
    firefox
    visual-studio-code-bin
    thunar-devel
    neofetch
    cava
    neo-matrix
    tty-clock
    noto-fonts
    noto-fonts-cjk
    noto-fonts-full-git
    rofi-git
    drun
    alacritty
    vim
    nano
    python-pywal
)

# Function to install yay
install_yay() {
    echo "Installing yay..."
    if [ "$(id -u)" != "0" ]; then
        echo "This section of the script must be run as root to clone yay into /opt."
        exit 1
    fi

    # Install dependencies for building AUR packages
    echo "Installing required dependencies..."
    pacman -S --needed --noconfirm git base-devel

    # Clone the yay repository into /opt if it doesn't already exist
    if [ -d /opt/yay ]; then
        echo "Directory /opt/yay already exists. Skipping clone step."
    else
        echo "Cloning the yay repository into /opt..."
        git clone https://aur.archlinux.org/yay.git /opt/yay
    fi

    # Change ownership of /opt/yay to the current user
    echo "Changing ownership of /opt/yay to the current user..."
    sudo chown -R $(logname):$(logname) /opt/yay

    # Build and install yay as the non-root user
    sudo -u $(logname) bash <<EOF
cd /opt/yay
echo "Building and installing yay..."
makepkg -si --noconfirm
EOF

    echo "yay has been successfully installed!"
}

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "yay is not installed. Installing yay..."
    install_yay
else
    echo "yay is already installed. Skipping installation."
fi

# Update the system
echo "Updating the system..."
yay -Syu --noconfirm

# Install packages
echo "Installing packages..."
for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    yay -S --needed --noconfirm "$pkg"
done

echo "All packages installed successfully!"

# Copy .config and Wallpapers directories to the home directory
USER_HOME="/home/$(logname)"
SOURCE_CONFIG="./.config"
SOURCE_WALLPAPERS="./Wallpapers"

echo "Copying .config and Wallpapers to $USER_HOME..."

# Ensure the source directories exist
if [ -d "$SOURCE_CONFIG" ]; then
    cp -r "$SOURCE_CONFIG" "$USER_HOME"
    echo "Copied .config to $USER_HOME"
else
    echo "Warning: $SOURCE_CONFIG directory does not exist. Skipping .config copy."
fi

if [ -d "$SOURCE_WALLPAPERS" ]; then
    cp -r "$SOURCE_WALLPAPERS" "$USER_HOME"
    echo "Copied Wallpapers to $USER_HOME"
else
    echo "Warning: $SOURCE_WALLPAPERS directory does not exist. Skipping Wallpapers copy."
fi

echo "Setup complete! Enjoy your FlamEs Hyprdots!"

# Ask the user if they want to reboot the system
read -p "Do you want to reboot your system now? (y/n): " choice
case "$choice" in
    y|Y ) 
        echo "Rebooting the system..."
        reboot
        ;;
    n|N )
        echo "Reboot skipped. You may need to reboot later to apply all changes."
        ;;
    * )
        echo "Invalid choice. Reboot skipped. Please reboot manually if needed."
        ;;
esac
