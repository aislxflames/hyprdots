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
    thunar
    neofetch
    cava
    neo-matrix
    tty-clock
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    rofi-git
    drun
    alacritty
    vim
    nano
    pywal
    zsh
    ttf-meslo-nerd-font-powerlevel10k
    gtk
    gnome-themes-standard
    nautilus
    sassc
    rsync
    nwg-look
    zsh-autosuggestions
    zsh-syntax-highlighting
    pokemon-colorscripts-git 
    sddm
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
        sudo git clone https://aur.archlinux.org/yay.git /opt/yay
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
    yay -S graphite-gtk-theme-dark-compact

echo "All packages installed successfully!"

echo "Installing gtk themes"
if [ ! -d /opt/Graphite-gtk-theme ]; then
  sudo git clone https://github.com/vinceliuice/Graphite-gtk-theme.git /opt/Graphite-gtk-theme
else
  echo "/opt/Graphite-gtk-theme already exists, skipping clone."
fi
cd /opt/Graphite-gtk-theme 
sudo ./install.sh  -d ~/.themes/ -t -c dark -s standard -l --tweaks darker rimless
cd ~
# Copy .config and Wallpapers directories to the home directory
USER_HOME="/home/$(logname)"
SOURCE_CONFIG="./.config/"
SOURCE_WALLPAPERS="./Wallpapers"

echo "Copying .config and Wallpapers to $USER_HOME..."
#Installing Oh my zsh
echo "Installing oh my zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "~/.oh-my-zsh already exists. Skipping installation."
else
    echo "~/.oh-my-zsh does not exist. Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo "Installing plugins"
sed -i '/^plugins=/,/)/c\plugins=(\n  git\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n)' ~/.zshrc
echo "Setup pokemon colorscripts"
if ! grep -q "pokemon-colorscripts -r" ~/.zshrc; then
    sed -i '1s/^/pokemon-colorscripts -r\n/' ~/.zshrc
    echo "Added pokemon-colorscripts -r to the beginning of ~/.zshrc"
else
    echo "pokemon-colorscripts -r already exists in ~/.zshrc. Skipping."
fi
sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc


# Ensure the source directories exist

if [ ! -d "$USER_HOME/.config" ]; then
    mkdir -p "$USER_HOME/.config"
    echo "Created .config directory at $USER_HOME"
fi

if [ -d "$SOURCE_CONFIG" ]; then
    rsync -av --ignore-existing "$SOURCE_CONFIG/" "$USER_HOME/.config"
    echo "Synced .config to $USER_HOME"
else
    echo "Warning: $SOURCE_CONFIG directory does not exist. Skipping .config copy."
fi

if [ ! -d "$USER_HOME/Wallpapers" ]; then
    mkdir -p "$USER_HOME/Wallpapers"
    echo "Created Wallpapers directory at $USER_HOME"
fi

if [ -d "$SOURCE_WALLPAPERS" ]; then
    rsync -av --ignore-existing "$SOURCE_WALLPAPERS/" "$USER_HOME/Wallpapers"
    echo "Synced Wallpapers to $USER_HOME"
else
    echo "Warning: $SOURCE_WALLPAPERS directory does not exist. Skipping Wallpapers copy."
fi
echo "Setup complete! Enjoy your FlamEs Hyprdots!"
#Start sddm
systemctl enable sddm
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
