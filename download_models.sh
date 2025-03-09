#!/usr/bin/env bash
set -e

echo "🚀 Downloading model files into ComfyUI..."

# Make sure the folders exist
mkdir -p /workspace/ComfyUI/models/checkpoints
mkdir -p /workspace/ComfyUI/models/clip
mkdir -p /workspace/ComfyUI/models/vae

# Download flux1-dev.safetensors -> checkpoints
wget -c -O /workspace/ComfyUI/models/checkpoints/flux1-dev.safetensors \
  https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors

# Download t5xxl_fp16.safetensors -> clip
wget -c -O /workspace/ComfyUI/models/clip/t5xxl_fp16.safetensors \
  https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors

# Download clip_l.safetensors -> clip
wget -c -O /workspace/ComfyUI/models/clip/clip_l.safetensors \
  https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors

# Download ae.safetensors -> vae
wget -c -O /workspace/ComfyUI/models/vae/ae.safetensors \
  https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors

echo "✅ Model download complete!"
