#!/bin/bash
set -e

echo "🚀 Setting up Elixir development environment..."

# Install basic dependencies
sudo apt-get update
sudo apt-get install -y curl wget git build-essential

# Install Erlang and Elixir directly (simpler than Guix for now)
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install -y esl-erlang elixir

# Install Node.js for Phoenix assets
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Phoenix
mix local.hex --force
mix archive.install hex phx_new --force

echo "✅ Environment setup complete!"
echo "Run 'mix phx.new chat_app --live' to create your project"
