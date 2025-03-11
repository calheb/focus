#!/usr/bin/env bash

SCRIPT_NAME="focus"
SCRIPT_PATH="/usr/local/bin/$SCRIPT_NAME"
SUDOERS_PATH="/etc/sudoers.d/focus"
SOURCE_SCRIPT="$(realpath "$0" | xargs dirname)/focus"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo privileges."
    echo "Please run: sudo $0"
    exit 1
fi

if [[ ! -f "$SOURCE_SCRIPT" ]]; then
    echo "ERROR: Could not find focus at $SOURCE_SCRIPT"
    echo "Please run this installer from the same directory as focus."
    exit 1
fi

setup_sudoers() {
    echo "Setting up sudo permissions..."
    # Create sudoers file
    echo "# Allow focus to run specific commands without password." | sudo tee "$SUDOERS_PATH" > /dev/null
    echo "%sudo ALL=(ALL) NOPASSWD: $SCRIPT_PATH" | sudo tee -a "$SUDOERS_PATH" > /dev/null
    echo "Defaults!$SCRIPT_PATH !requiretty" | sudo tee -a "$SUDOERS_PATH" > /dev/null
    echo "Defaults!$SCRIPT_PATH env_keep += \"PATH\"" | sudo tee -a "$SUDOERS_PATH" > /dev/null
    
    sudo chmod 440 "$SUDOERS_PATH"
}

install_script() {
    echo "Installing focus to $SCRIPT_PATH..."
    sudo cp "$SOURCE_SCRIPT" "$SCRIPT_PATH"
    sudo chmod +x "$SCRIPT_PATH"
}

echo "Installing focus..."
setup_sudoers
install_script

echo -e "\nInstallation complete! Type 'focus' to view available commands."
