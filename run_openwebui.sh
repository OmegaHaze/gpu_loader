#!/usr/bin/env bash
set -e

echo "Starting Python backend..."
cd /workspace/OpenWebUI/backend
python3 -m open_webui serve --host 0.0.0.0 --port 7860 &
sleep 3

echo "Serving front-end on port 3000..."
npx serve -s build -l 3000
