#!/bin/bash
set -e

echo "Setting up Phoenix project..."

# Install Phoenix
mix archive.install hex phx_new --force

# Create Phoenix project
mix phx.new chat_ui --live --no-ecto

cd chat_ui

# Install dependencies
mix deps.get

# Install Node.js dependencies
cd assets && npm install && cd ..

echo "Phoenix project setup complete!"
echo "Run 'mix phx.server' to start the development server"
