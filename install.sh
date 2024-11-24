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


# Function to install yay
install_yay() {
     echo "Installing yay.."

    # Install dependencies for building AUR packages
    echo "Installing required dependencies..."
    sudo pacman -S --needed --noconfirm git base-devel

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

#!/bin/bash
    USER_HOME="/home/$(logname)"
    SOURCE_CONFIG="./.config"
    SOURCE_WALLPAPERS="./Wallpapers"
# Ask if the user wants to proceed with the setup
read -p "Do you want to proceed with the full setup (install packages, copy config files, and more)? (y/n): " response

if [[ "$response" =~ ^[Yy]$ ]]; then

    # List of packages to install
    packages=(
    hyprland
    waybar
    waypaper
    thunar
    firefox
    thunar
    pavucontrol
    neofetch
    cava
    neo-matrix
    tty-clock
    cliphist
    rofimoji
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
    gnome-software
    sassc
    rsync
    nwg-look
    zsh-autosuggestions-git
    zsh-syntax-highlighting-git
    pokemon-colorscripts-git
    blueman
    bluez
    swww
    hyprpaper
    sddm
)  # Replace with your actual packages

    # Install packages
    echo "Installing packages..."
    for pkg in "${packages[@]}"; do
        echo "Installing $pkg..."
        yay -S --needed --noconfirm "$pkg"
    done
    echo "All packages installed successfully!"

    # Ask if the user wants to install additional packages (sddm-theme-sugar-candy-git, visual-studio-bin)
    read -p "Do you want to install the additional packages (sddm-theme-sugar-candy-git, visual-studio-bin)? (y/n): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        yay -S sddm-theme-sugar-candy-git
        yay -S visual-studio-bin
        echo "Additional packages installed: sddm-theme-sugar-candy-git and visual-studio-bin."
    else
        echo "No additional packages installed."
    fi

    # Copy .config and Wallpapers directories to the home directory

    echo "Copying .config and Wallpapers to $USER_HOME..."
    cp -r "$SOURCE_CONFIG" "$USER_HOME/"
    cp -r "$SOURCE_WALLPAPERS" "$USER_HOME/"
    echo ".config and Wallpapers copied successfully!"

    # Ask if the user wants to install Oh My Zsh
    read -p "Do you want to install Oh My Zsh? (y/n): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "Oh My Zsh installed."
    else
        echo "Skipping Oh My Zsh installation."
    fi

    echo "Setup complete!"

else
    echo "Setup was cancelled."
fi

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
# Check if ~/powerlevel10k exists and remove it if it does
if [ -d "$USER_HOME/powerlevel10k" ]; then
    echo "Removing ~/powerlevel10k..."
    sudo rm -r ~/powerlevel10k
else
    echo "~/powerlevel10k does not exist, skipping removal."
fi

# Check if ~/oh-my-zsh/custom/themes/powerlevel10k exists and remove it if it does
if [ -d "$USER_HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Removing ~/oh-my-zsh/custom/themes/powerlevel10k..."
    sudo rm -r ~/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "~/.oh-my-zsh/custom/themes/powerlevel10k does not exist, skipping removal."
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc


# Ensure the source directories exist

if [ ! -d "$USER_HOME/.config" ]; then
    mkdir -p "$USER_HOME/.config"
    echo "Created .config directory at $USER_HOME"
fi

if [ -d "$USER_HOME/.config" ]; then
    rsync -av --ignore-existing "$SOURCE_CONFIG/" "$USER_HOME/.config/"
    echo "Synced .config to $USER_HOME"
else
    echo "Warning: $SOURCE_CONFIG directory does not exist. Skipping .config copy."
fi

if [ ! -d "$USER_HOME/Wallpapers" ]; then
    mkdir -p "$USER_HOME/Wallpapers"
    echo "Created Wallpapers directory at $USER_HOME"
fi

if [ -d "$USER_HOME/Wallpapers"  ]; then
    rsync -av --ignore-existing "$SOURCE_WALLPAPERS/" "$USER_HOME/Wallpapers/"
    echo "Synced Wallpapers to $USER_HOME"
else
    echo "Warning: $SOURCE_WALLPAPERS directory does not exist. Skipping Wallpapers copy."
fi
echo "Setup complete! Enjoy your FlamEs Hyprdots!"

echo "Installing gtk themes"
if [ ! -d /opt/Graphite-gtk-theme ]; then
  sudo git clone https://github.com/vinceliuice/Graphite-gtk-theme.git /opt/Graphite-gtk-theme
else
  echo "/opt/Graphite-gtk-theme already exists, skipping clone."
fi
cd /opt/Graphite-gtk-theme 
sudo ./install.sh  -d ~/.themes/ -t -c dark -s standard -l --tweaks darker rimless
cd ~
# Check if bluetooth is already enabled

if systemctl is-enabled --quiet bluetooth; then
    echo "bluetooth is already enabled, skipping."
else
    echo "Enabling bluetooth..."
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth  # Optionally, start the service immediately
    echo "bluetooth has been enabled and started."
fi

# Check if sddm is already enabled

if systemctl is-enabled --quiet sddm; then
    echo "sddm is already enabled, skipping."
else
    echo "Enabling sddm..."
    sudo systemctl enable sddm
    sudo systemctl start sddm  # Optionally, start the service immediately
    echo "sddm has been enabled and started."
fi

echo "Setting POWERLEVEL9K_INSTANT_PROMPT=off"
# Check if POWERLEVEL9K_INSTANT_PROMPT=off is already in ~/.zshrc
if ! grep -q "typeset -g POWERLEVEL9K_INSTANT_PROMPT=off" ~/.zshrc; then
    # If not found, append it to the very last line of ~/.zshrc using sed
    sed -i -e '$a\' -e 'typeset -g POWERLEVEL9K_INSTANT_PROMPT=off' ~/.zshrc
    echo "Added typeset -g POWERLEVEL9K_INSTANT_PROMPT=off to the bottom of ~/.zshrc"
else
    echo "POWERLEVEL9K_INSTANT_PROMPT=off already exists in ~/.zshrc. Skipping."
fi
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
