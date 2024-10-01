#!/bin/bash

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Update the system
echo "Updating the system..."
sudo yum update -y

# Install required packages
echo "Installing required packages..."
sudo yum install -y yum-utils

# Add the Docker repository
echo "Adding Docker repository..."
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

# Install Docker
echo "Installing Docker..."
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# Start and enable Docker service
echo "Starting and enabling Docker service..."
systemctl start docker
systemctl enable docker

# Add current user to docker group (to run docker without sudo)
echo "Adding user $current_user to docker group..."
sudo groupadd docker
sudo usermod -aG docker $USER

#Log out and log back in so that your group membership is re-evaluated.
newgrp docker

#Verify that you can run docker commands without sudo.
docker run hello-world

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version
docker compose version

echo "Docker installation complete!"
echo "Please log out and log back in for group changes to take effect."
echo "You can then run Docker commands without sudo."