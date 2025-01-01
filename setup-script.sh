#!/bin/bash

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

sudo apt update
sudo apt install net-tools
sudo ufw --force enable
sudo ufw allow $PORT_SSH
sudo ufw allow $PORT_SMTP
sudo ufw allow $PORT_HTTP
sudo ufw allow $PORT_HTTPS
sudo apt install docker.io

# Define the public key to be added
PUBLIC_KEY=$PUB_KEY

# Path to the authorized_keys file
AUTHORIZED_KEYS_FILE="$HOME/.ssh/authorized_keys"

# Ensure the .ssh directory exists
mkdir -p "$HOME/.ssh"

# Add the public key to the authorized_keys file if it doesn't already exist
if ! grep -q "$PUBLIC_KEY" "$AUTHORIZED_KEYS_FILE"; then
  echo "Adding the public key to $AUTHORIZED_KEYS_FILE"
  echo "$PUBLIC_KEY" >> "$AUTHORIZED_KEYS_FILE"
else
  echo "Public key already exists in $AUTHORIZED_KEYS_FILE"
fi

# Set the appropriate permissions
chmod 700 "$HOME/.ssh"
chmod 600 "$AUTHORIZED_KEYS_FILE"

# Reload the SSH service (for systems that use systemd)
if systemctl list-units --type=service | grep -q "ssh"; then
  echo "Reloading SSH service"
  sudo systemctl reload ssh
else
  echo "SSH service not found. Please restart it manually if necessary."
fi

