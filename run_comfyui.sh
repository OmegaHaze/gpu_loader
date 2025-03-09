#!/usr/bin/env bash
set -e

echo "🔍 Detecting GPUs for ComfyUI..."
NUM_GPUS=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "🔥 Detected: $NUM_GPUS GPUs"

# Priority-based GPU allocation (sort by memory desc)
if [ "$NUM_GPUS" -gt 1 ]; then
    echo "🔄 Multi-GPU mode (NCCL + torchrun) enabled"
    GPU_LIST=$(nvidia-smi --query-gpu=index,memory.total --format=csv,noheader \
               | sort -t, -k2 -nr \
               | cut -d, -f1 \
               | paste -sd ,)
    export CUDA_VISIBLE_DEVICES=$GPU_LIST
    echo "CUDA_VISIBLE_DEVICES=$GPU_LIST"

    # Torch distributed run for multi-GPU
    cd /workspace/ComfyUI
    exec torchrun --nproc_per_node=$NUM_GPUS --nnodes=1 \
         --master_addr='127.0.0.1' --master_port=29500 \
         main.py --listen 0.0.0.0 --port 8188 \
         >> /workspace/logs/comfyui_stdout.log 2>&1
else
    echo "🖥 Single GPU mode"
    cd /workspace/ComfyUI
    exec python main.py --listen 0.0.0.0 --port 8188 \
         >> /workspace/logs/comfyui_stdout.log 2>&1
fi
