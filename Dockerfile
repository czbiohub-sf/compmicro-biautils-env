# Multi-stage build for Pixi-based environment
# Based on: https://tech.quantco.com/blog/pixi-production
FROM ghcr.io/prefix-dev/pixi:0.51.0-focal-cuda-12.8.1 AS builder

# Set working directory
WORKDIR /app

# Copy pixi configuration files first (better layer caching)
COPY pixi.toml ./

# Install git for GitHub dependencies and install environment
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && pixi install --environment default \
    && rm -rf ~/.cache/rattler

# Copy source code after dependencies (better caching)
COPY src/ ./src/
COPY README.md LICENSE ./

# Final runtime stage - no pixi binary needed
FROM debian:bookworm-slim

# Install runtime dependencies for GUI support
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    libxcb-xinput0 \
    libxcb-xfixes0 \
    libxcb-shape0 \
    libfontconfig1 \
    libxrender1 \
    libxi6 \
    libdbus-1-3 \
    && rm -rf /var/lib/apt/lists/*

# Copy only the environment from builder (no pixi binary needed)
COPY --from=builder /app/.pixi/envs/default /app/.pixi/envs/default

# Copy source code and configuration
COPY --from=builder /app/src /app/src
COPY --from=builder /app/README.md /app/LICENSE /app/

# Set working directory
WORKDIR /app

# Set up environment activation (from pixi shell-hook)
ENV PATH="/app/.pixi/envs/default/bin:${PATH}"
ENV CONDA_PREFIX="/app/.pixi/envs/default"
ENV PYTHONPATH="/app/src"

# Direct Python execution without pixi runtime
CMD ["python", "-c", "import biautils; biautils.print_environment_info()"]
