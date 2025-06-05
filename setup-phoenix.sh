#!/bin/bash
set -e

echo "🚀 Setting up Phoenix project..."

# Check if we're in a Guix environment or using system packages
if command -v guix &> /dev/null; then
    echo "Using Guix environment..."
    # Install Phoenix in Guix environment
    mix local.hex --force
    mix archive.install hex phx_new --force
else
    echo "Using system packages..."
    # Phoenix should already be installed by setup.sh
fi

# Create Phoenix project
echo "Creating Phoenix project 'chat_app'..."
mix phx.new chat_app --live --no-ecto

cd chat_app

# Install dependencies
echo "Installing Elixir dependencies..."
mix deps.get

# Install Node.js dependencies
echo "Installing Node.js dependencies..."
cd assets && npm install && cd ..

echo "✅ Phoenix project setup complete!"
echo ""
echo "Next steps:"
echo "1. cd chat_app"
echo "2. Add the chat LiveView files"
echo "3. mix phx.server"
