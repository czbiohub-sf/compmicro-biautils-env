# Makefile for Docker operations
.PHONY: help build run run-gui run-batch clean push pull shell debug size

# Variables
IMAGE_NAME := biautils
IMAGE_TAG := latest
FULL_IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)
REGISTRY := # Add your registry here, e.g., ghcr.io/czbiohub-sf

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

build: ## Build the Docker image with optimizations (linux/amd64)
	@echo "Building $(FULL_IMAGE) for linux/amd64..."
	DOCKER_BUILDKIT=1 docker build --platform linux/amd64 -t $(FULL_IMAGE) .

build-nocache: ## Build the Docker image without cache (linux/amd64)
	@echo "Building $(FULL_IMAGE) without cache for linux/amd64..."
	DOCKER_BUILDKIT=1 docker build --platform linux/amd64 --no-cache -t $(FULL_IMAGE) .

run: ## Run the container (batch mode)
	docker run --rm \
		-v $(PWD)/data:/app/data \
		$(FULL_IMAGE)

run-gui: ## Run the container with GUI support (Linux only)
	xhost +local:docker 2>/dev/null || true
	docker run --rm -it \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
		-v $(PWD)/data:/app/data \
		--network host \
		$(FULL_IMAGE)

run-batch: ## Run the container in batch processing mode
	docker run --rm \
		-v $(PWD)/data:/app/data \
		$(FULL_IMAGE) \
		python -c "import biautils; print('Batch processing mode')"

shell: ## Open a shell in the container
	docker run --rm -it \
		-v $(PWD)/data:/app/data \
		--entrypoint /bin/bash \
		$(FULL_IMAGE)

debug: ## Run container with debugging capabilities
	docker run --rm -it \
		-v $(PWD):/workspace \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
		--network host \
		--entrypoint /bin/bash \
		$(FULL_IMAGE)

size: ## Show image size and layer information
	@echo "Image size:"
	@docker image ls $(FULL_IMAGE)
	@echo "\nLayer details:"
	@docker history $(FULL_IMAGE)

clean: ## Remove the Docker image and build cache
	docker rmi $(FULL_IMAGE) 2>/dev/null || true
	docker builder prune -f

push: ## Push image to registry
	@if [ -z "$(REGISTRY)" ]; then \
		echo "Error: REGISTRY not set"; \
		exit 1; \
	fi
	docker tag $(FULL_IMAGE) $(REGISTRY)/$(FULL_IMAGE)
	docker push $(REGISTRY)/$(FULL_IMAGE)

pull: ## Pull image from registry
	@if [ -z "$(REGISTRY)" ]; then \
		echo "Error: REGISTRY not set"; \
		exit 1; \
	fi
	docker pull $(REGISTRY)/$(FULL_IMAGE)
	docker tag $(REGISTRY)/$(FULL_IMAGE) $(FULL_IMAGE)

save: ## Save image to tarball for HPC transfer
	@echo "Saving $(FULL_IMAGE) to biautils.tar.gz..."
	docker save $(FULL_IMAGE) | gzip > biautils.tar.gz
	@echo "Saved to biautils.tar.gz ($(shell du -h biautils.tar.gz | cut -f1))"

load: ## Load image from tarball
	@echo "Loading image from biautils.tar.gz..."
	gunzip -c biautils.tar.gz | docker load

compose-up: ## Start services with docker-compose
	docker-compose up -d

compose-down: ## Stop services with docker-compose
	docker-compose down

compose-logs: ## Show docker-compose logs
	docker-compose logs -f

test: build ## Build and run basic tests
	@echo "Testing image..."
	docker run --rm $(FULL_IMAGE) python -c "import biautils; print('✓ biautils imported successfully')"
	docker run --rm $(FULL_IMAGE) python -c "import napari; print('✓ napari imported successfully')"
	docker run --rm $(FULL_IMAGE) python -c "import viscy; print('✓ viscy imported successfully')"
	@echo "All tests passed!"

# HPC-specific targets
hpc-build: ## Build for HPC deployment (linux/amd64)
	docker buildx build --platform linux/amd64 -t $(FULL_IMAGE)-hpc .

# Cross-platform build (build on Mac, target Linux x86_64)
cross-build: ## Build for Linux x86_64 from any platform
	@echo "Building $(FULL_IMAGE) for linux/amd64 (cross-platform)..."
	docker buildx build --platform linux/amd64 -t $(FULL_IMAGE) .
	@echo "Cross-platform build complete!"

apptainer: ## Convert to Apptainer image for HPC
	@which apptainer > /dev/null || (echo "Error: apptainer not found" && exit 1)
	apptainer build biautils.sif docker-daemon://$(FULL_IMAGE)
	@echo "Created biautils.sif for HPC deployment"
