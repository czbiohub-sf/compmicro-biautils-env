# Docker Deployment Guide

This guide explains how to build and deploy the biautils environment using Docker, following best practices from [QuantCo's pixi production guide](https://tech.quantco.com/blog/pixi-production).

## Architecture

The Dockerfile uses a multi-stage build approach optimized for pixi environments:

1. **Builder Stage**: Uses the official pixi image to install dependencies
2. **Runtime Stage**: Minimal Debian image with only the environment and GUI dependencies

## Key Optimizations

Based on the QuantCo blog post, we implement several optimizations:

### 1. Cache Removal
```dockerfile
RUN pixi install --locked --environment default && \
    rm -rf ~/.cache/rattler
```
Removes the rattler cache in the same layer to reduce image size by ~290MB.

### 2. No Pixi Binary in Runtime
The runtime stage doesn't include the pixi binary (saves ~37MB), instead using direct environment activation:
```dockerfile
ENV PATH="/app/.pixi/envs/default/bin:${PATH}"
ENV CONDA_PREFIX="/app/.pixi/envs/default"
```

### 3. Layer Caching
Dependencies are installed before copying source code, enabling better Docker layer caching during development.

## Building the Image

### Basic Build
```bash
docker build -t biautils:latest .
```

### Build with BuildKit (recommended for faster builds)
```bash
DOCKER_BUILDKIT=1 docker build -t biautils:latest .
```

### Cross-platform Build (if needed)
```bash
docker buildx build --platform linux/amd64 -t biautils:latest .
```

## Running the Container

### With GUI Support (Linux)
```bash
docker run --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --network host \
  biautils:latest
```

### HPC Batch Mode (no GUI)
```bash
docker run --rm \
  -v $(pwd)/data:/app/data \
  biautils:latest \
  python -m biautils.process
```

### Using Docker Compose
```bash
# Start with GUI support
docker-compose up biautils

# Start batch processing
docker-compose up biautils-batch
```

## Image Size Analysis

Check the image size and layers:
```bash
# View image size
docker image ls biautils:latest

# Analyze layers
docker history biautils:latest
```

Expected sizes with optimizations:
- Without cache removal: ~690MB
- With cache removal: ~400MB
- Without pixi binary: ~360MB

## Deployment to HPC

### Save Image for Transfer
```bash
# Save as tarball
docker save biautils:latest | gzip > biautils.tar.gz

# On HPC system
gunzip -c biautils.tar.gz | docker load
```

### Using Apptainer
```bash
# Convert to Apptainer image
apptainer build biautils.sif docker-daemon://biautils:latest

# Run with Apptainer
apptainer run biautils.sif
```

## Alternative: pixi-pack for Non-Docker Environments

For HPC systems without Docker support, consider using `pixi-pack`:

```bash
# Install pixi-pack
pixi global install pixi-pack

# Create portable archive
pixi-pack pack --manifest-file pixi.toml --platform linux-64

# Deploy and unpack on HPC
pixi-pack unpack environment.tar
```

## Troubleshooting

### GUI Applications Not Working
Ensure X11 forwarding is enabled:
```bash
xhost +local:docker
```

### Permission Issues
Add user mapping to match HPC user:
```dockerfile
RUN useradd -m -u 1000 -s /bin/bash hpcuser
USER hpcuser
```

### CUDA Support
For GPU-enabled environments, use NVIDIA base images:
```dockerfile
FROM nvidia/cuda:12.0-runtime-ubuntu22.04
```

## Security Considerations

1. **Never include `.pixi/` directory** in the build context (handled by `.dockerignore`)
2. **Use specific pixi versions** instead of `latest` tag for reproducibility
3. **Run as non-root user** in production environments
4. **Minimize attack surface** by only installing required runtime dependencies

## Performance Tips

1. **Use BuildKit** for parallel builds and better caching
2. **Leverage multi-stage builds** to minimize final image size
3. **Order Dockerfile commands** from least to most frequently changing
4. **Use `.dockerignore`** to exclude unnecessary files from build context

## References

- [QuantCo: Shipping conda environments to production using pixi](https://tech.quantco.com/blog/pixi-production)
- [Pixi Documentation](https://pixi.sh/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
