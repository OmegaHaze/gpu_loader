#!/usr/bin/env bash
set -e

echo "🎨 Starting OpenWebUI..."

# Run in production mode (optional)
export NODE_ENV=production

cd /workspace/OpenWebUI
exec yarn start
