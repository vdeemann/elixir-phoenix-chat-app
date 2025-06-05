#!/bin/bash
set -e

echo "🚀 Creating Phoenix chat application..."

# Create Phoenix project
mix phx.new chat_app --live --no-ecto

cd chat_app

# Install dependencies
mix deps.get
cd assets && npm install && cd ..

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. cd chat_app"
echo "2. Add the LiveView files"
echo "3. mix phx.server"
