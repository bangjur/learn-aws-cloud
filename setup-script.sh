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
