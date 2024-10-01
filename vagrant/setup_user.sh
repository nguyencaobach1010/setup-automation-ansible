#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Prompt for the username
read -p "Enter the username to grant sudo access without a password: " USERNAME

# Check if the user exists
if id "$USERNAME" &>/dev/null; then
    echo "Granting sudo access to $USERNAME..."

    # Add the user to the sudoers file
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME

    # Set appropriate permissions on the sudoers file
    chmod 440 /etc/sudoers.d/$USERNAME

    echo "Sudo access granted to $USERNAME without password prompt."
else
    echo "User $USERNAME does not exist."
    exit 1
fi
