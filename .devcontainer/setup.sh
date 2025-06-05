#!/bin/bash
set -e

echo "🚀 Setting up development environment..."

# Install basic dependencies
sudo apt-get update
sudo apt-get install -y curl wget git build-essential xz-utils

# Try to install Guix (if it fails, we'll fall back to direct installation)
if ! command -v guix &> /dev/null; then
    echo "Installing GNU Guix..."
    cd /tmp
    wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
    chmod +x guix-install.sh
    
    # Try Guix installation
    if sudo ./guix-install.sh; then
        echo "✅ Guix installed successfully"
        echo 'export PATH="/var/guix/profiles/per-user/root/current-guix/bin:$PATH"' >> ~/.bashrc
        export PATH="/var/guix/profiles/per-user/root/current-guix/bin:$PATH"
    else
        echo "⚠️  Guix installation failed, using direct package installation"
        # Fallback to direct installation
        wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
        sudo dpkg -i erlang-solutions_2.0_all.deb
        sudo apt-get update
        sudo apt-get install -y esl-erlang elixir
        
        # Install Node.js
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
        
        # Install Phoenix
        mix local.hex --force
        mix archive.install hex phx_new --force
    fi
fi

echo "✅ Environment setup complete!"
