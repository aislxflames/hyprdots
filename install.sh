#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
clear
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
    sudo pacman -S --needed --noconfirm git base-devel  > /dev/null 2>&1

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
yay -Syu --noconfirm  > /dev/null 2>&1

# Install packages

#!/bin/bash
    USER_HOME="/home/$(logname)"
    SOURCE_CONFIG="./.config"
    SOURCE_WALLPAPERS="./Wallpapers"
# Ask if the user wants to proceed with the setup

read -p "Do you want to proceed with the full setup (install packages, installing bluetooth,wifi,waybar,hyprland and more)? (y/n): " response

if [[ "$response" =~ ^[Yy]$ ]]; then
    clear
echo "========================================================="
echo " ___ _   _ ____ _____  _    _     _     ___ _   _  ____ "
echo "|_ _| \ | / ___|_   _|/ \  | |   | |   |_ _| \ | |/ ___|"
echo " | ||  \| \___ \ | | / _ \ | |   | |    | ||  \| | |  _ "
echo " | || |\  |___) || |/ ___ \| |___| |___ | || |\  | |_| |"
echo "|___|_| \_|____/ |_/_/   \_\_____|_____|___|_| \_|\____|"
echo "========================================================="

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
    gtk
    gnome-themes-standard
    gnome-software
    sassc
    rsync
    nwg-look
    pokemon-colorscripts-git
    blueman
    bluez
    swww
    hyprpaper
    network-manager-applets
    sddm
)  # Replace with your actual packages

    # Install packages
    echo "Installing packages..."
    for pkg in "${packages[@]}"; do
        echo "Installing $pkg..."
        yay -S --needed --noconfirm "$pkg"
    done
    echo "All packages installed successfully!"
    clear
echo "================================================================================"
echo "    _    ____  ____ ___ _____ ___ ___  _   _    _    _       ____  _  ______"
echo "   / \  |  _ \|  _ \_ _|_   _|_ _/ _ \| \ | |  / \  | |     |  _ \| |/ / ___|"
echo "  / _ \ | | | | | | | |  | |  | | | | |  \| | / _ \ | |     | |_) | ' / |  _ "
echo " / ___ \| |_| | |_| | |  | |  | | |_| | |\  |/ ___ \| |___  |  __/| . \ |_| |"
echo "/_/   \_\____/|____/___| |_| |___\___/|_| \_/_/   \_\_____| |_|   |_|\_\____|"
echo "================================================================================="
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


    # Ask if the user wants to install Oh My Zsh
    clear
echo "====================================================="
echo "  ___  _   _   __  ____   __  _________  _   _     "
echo " / _ \\| | | | |  \\/  \\ \\ / / |__  / ___|| | | |    "
echo "| | | | |_| | | |\\/| |\\ V /    / /\\___ \\| |_| |    "
echo "| |_| |  _  | | |  | | | |    / /_ ___) |  _  |    "
echo " \\___/|_| |_| |_|  |_| |_|   /____|____/|_| |_|    "
echo "====================================================="

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
clear
echo "====================================================="
echo " ____   ___ _____   _____ ___ _     _____ ____     "
echo "|  _ \\ / _ \\_   _| |  ___|_ _| |   | ____/ ___|    "
echo "| | | | | | || |   | |_   | || |   |  _| \\___ \\    "
echo "| |_| | |_| || |   |  _|  | || |___| |___ ___) |   "
echo "|____/ \\___/ |_|   |_|   |___|_____|_____|____/    "
echo "====================================================="

# Ask if user wants to copy dotfiles and wallpapers
read -p "Do you want to copy dotfiles and wallpapers (y/n): " response  # Capture user input into the response variable
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Copying .config and Wallpapers to $USER_HOME..."
    cp -r "$SOURCE_CONFIG" "$USER_HOME/"
    cp -r "$SOURCE_WALLPAPERS" "$USER_HOME/"
    echo ".config and Wallpapers copied successfully!"
else 
    echo "Skipping copying files"
fi

# Ask if user wants to install oh my zsh and login manager
clear
echo "====================================================="
echo "  ____ ___  _   _ _____ ___ _   _ _   _ _____   ___ "
echo " / ___/ _ \\| \\ | |_   _|_ _| \\ | | | | | ____| |__ \\"
echo "| |  | | | |  \\| | | |  | ||  \\| | | | |  _|     / /"
echo "| |__| |_| | |\\  | | |  | || |\\  | |_| | |___   |_||"
echo " \\____\\___/|_| \\_| |_| |___|_| \\_|\\___/|_____|  (_)"
echo "====================================================="

read -p "Do you wanna continue setup? (y/n): " response  # Capture user input again into the response variable
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Continuing" # Exit the script if user chooses 'y' or 'Y'
else
    exit
fi

yay -S --needed --noconfirm zsh

#Installing Oh my zsh
echo "Installing oh my zsh"

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "~/.oh-my-zsh already exists. Skipping installation."
else
    echo "~/.oh-my-zsh does not exist. Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo "zsh plugins installing"
yay -S --needed --noconfirm ttf-meslo-nerd-font-powerlevel10k

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

# Check if ~/powerlevel10k exists and remove it if it does
if [ ! -d "$USER_HOME/powerlevel10k" ]; then
    echo "Cloning powerlevel10k repository..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $USER_HOME/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "$USER_HOME/powerlevel10k already exists, skipping clone."
fi
sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.zshrc
# Check if the powerlevel10k source line is already in ~/.zshrc
if ! grep -q 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' ~/.zshrc; then
    echo 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo "Added powerlevel10k to ~/.zshrc"
else
    echo "powerlevel10k is already in ~/.zshrc, skipping."
fi
# Check if the zsh-autosuggestions source line is already in ~/.zshrc
# Check if zsh-autosuggestions already exists
if [ ! -d "$USER_HOME/.zsh/zsh-autosuggestions" ]; then
    echo "Cloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $USER_HOME/.zsh/zsh-autosuggestions
else
    echo "$USER_HOME/.zsh/zsh-autosuggestions already exists, skipping clone."
fi
if ! grep -q 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' ~/.zshrc; then
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
    echo "Added zsh-autosuggestions to ~/.zshrc"
else
    echo "zsh-autosuggestions is already in ~/.zshrc, skipping."
fi

# Check if the zsh-syntax-highlighting source line is already in ~/.zshrc
if ! grep -q 'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ~/.zshrc; then
    echo 'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
    echo "Added zsh-syntax-highlighting to ~/.zshrc"
else
    echo "zsh-syntax-highlighting is already in ~/.zshrc, skipping."
fi

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
clear
echo "====================================================="
echo " _____ ___ _   _ ___ ____  _   _ _____ ____      "
echo "|  ___|_ _| \\ | |_ _/ ___|| | | | ____|  _ \\     "
echo "| |_   | ||  \\| || |\\___ \\| |_| |  _| | | | |    "
echo "|  _|  | || |\\  || | ___) |  _  | |___| |_| |    "
echo "|_|   |___|_| \\_|___|____/|_| |_|_____|____/     "
echo "====================================================="

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


