#!/bin/bash
set -e

echo "Setting up GNU Guix development environment..."

# Install dependencies first
sudo apt-get update
sudo apt-get install -y wget curl gpg

# Install Guix
cd /tmp
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
sudo ./guix-install.sh

# Add Guix to PATH for current session
export PATH="$HOME/.config/guix/current/bin:$PATH"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

# Add to bashrc for future sessions
echo 'export PATH="$HOME/.config/guix/current/bin:$PATH"' >> ~/.bashrc
echo 'export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"' >> ~/.bashrc

# Create cache directory
mkdir -p ~/.cache/guix

echo "Guix setup complete!"
