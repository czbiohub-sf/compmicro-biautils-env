# Installation

This document provides installation instructions for the **biautils** computational microscopy environment, specifically designed for use on the Bruno HPC cluster at CZ Biohub San Francisco.

## Overview

The biautils environment provides a comprehensive suite of tools for N-dimensional microscopy data analysis, including image processing, machine learning libraries, specialized microscopy packages, and GPU acceleration with CUDA 12 support.

This environment is specifically configured for the Bruno HPC cluster and uses [`pixi`][pixi-docs] for dependency management.

## Prerequisites

- Access to the Bruno HPC cluster
- Basic command line knowledge
- Git access to the repository

## Installation Methods

### Pixi (Recommended)

Pixi is the recommended method for installing and managing the biautils environment on Bruno. Pixi provides robust environment management with automatic dependency resolution.

#### How Pixi Environments Work

Pixi creates isolated environments in the `compmicro-biautils-env/.pixi/envs` directory that contain:
- Standard directories (`bin`, `lib`, `include`) with all required packages
- Automatic PATH configuration and environment variable setup
- Package-specific activation scripts
- Metadata for environment validation and updates

#### Installation Steps

1. **Load the pixi module on Bruno:**
   ```bash
   module load pixi
   ```

2. **Clone the repository:**
   ```bash
   git clone https://github.com/czbiohub-sf/compmicro-biautils-env.git
   cd compmicro-biautils-env
   ```

3. **Checkout the desired version:**
   ```bash
   git checkout v${RELEASE_VERSION}
   ```
   See available versions in the [releases][cmbiautils-env-releases].

4. **Install the environment:**
   ```bash
   pixi install
   ```

5. **Activate and use the environment:**

   **Option A: Start a shell with the environment activated**
   ```bash
   pixi shell
   ```

   **Option B: Run commands directly in the environment**
   ```bash
   pixi run napari
   pixi run python your_analysis_script.py
   ```

### Container Options (Docker/Apptainer)

For users who prefer containerized environments, pre-built containers are available.

#### Docker
```bash
docker run ghcr.io/czbiohub-sf/compmicro-biautils-env:v${RELEASE_VERSION}
```

#### Apptainer (Recommended for HPC)
Apptainer is better suited for HPC environments like Bruno:

**Run a command in the container:**
```bash
apptainer run docker://ghcr.io/czbiohub-sf/compmicro-biautils-env:v${RELEASE_VERSION}
```

**Start an interactive shell:**
```bash
apptainer exec docker://ghcr.io/czbiohub-sf/compmicro-biautils-env:v${RELEASE_VERSION} bash
```

## Environment Verification

After installation, verify your environment is working correctly:

1. **Check the environment version:**
     ```bash
     pixi run env-info
     ```

     :::{note} Example pixi run env-info output
     :class: dropdown

     ```shell
     ╭──────────────────────────────────────────────────────────────────────────╮
     │ 🐸 biautils version: 0.0.0.post8.dev0+5332e73 | 🐍 Python: 3.11.0        │
     ╰──────────────────────────────────────────────────────────────────────────╯
     📦 Dependencies
     ├── 🦠 Napari
     │   ├── ✅ napari (0.6.3)
     │   ├── ✅ napari-ome-zarr (0.6.1)
     │   ├── ✅ napari-animation (0.0.9)
     │   └── ✅ napari-iohub (0.1.0a1.dev1+g8ccff7c)
     ├── 🔬 Scientific Computing
     │   ├── ✅ scipy (1.15.2)
     │   ├── ✅ numpy (2.2.6)
     │   └── ✅ scikit-learn (1.7.1)
     ├── 🚀 Pipeline
     │   └── ✅ biahub (0.1.0)
     ├── 🧠 AI/ML
     │   ├── ✅ ultrack (0.7.0rc1)
     │   └── ✅ catboost (1.2.8)
     ├── 🔍 Image Processing
     │   ├── ✅ waveorder (3.0.0a1)
     │   ├── ✅ viscy (0.3.2)
     │   └── ✅ cucim (25.8.0)
     ├── ⚡ GPU Acceleration
     │   └── ✅ cupy (13.5.1)
     └── 🛠️ Development
         └── ✅ ipykernel (6.30.1)
     ╭──────────────────────────────────────────────────────────────────────────╮
     │ 📊 Summary: 15/15 packages installed ✨ All dependencies available!      │
     ╰──────────────────────────────────────────────────────────────────────────╯
     ```
     :::

2. **Verify package installation:**
   ```bash
   pixi list
   ```

3. **Open Napari:**
   ```bash
   pixi run start-napari
   ```

## Pixi CLI Command Reference

Once you have pixi installed and your environment set up, here are the key commands for managing your biautils environment:

### Environment Management
- **[`pixi install`][pixi-cli-install]** - Install or update the environment based on `pixi.toml`
  ```bash
  pixi install
  ```

- **[`pixi clean`][pixi-cli-clean]** - Clean cached files and temporary data
  ```bash
  pixi clean
  pixi clean cache  # Clean only the package cache
  ```

### Environment Activation
- **[`pixi shell`][pixi-cli-shell]** - Start an interactive shell and activate the environment
  ```bash
  pixi shell
  ```

  :::{note} Example pixi shell output
  :class: dropdown

     ```shell
   [<firstname>.<lastname>@compute-node compmicro-biautils-env]$ pixi shell

   (biautils) [<firstname>.<lastname>@compute-node compmicro-biautils-env]$
   ```
  Note that this looks quite a bit like activating an Anaconda environment!
  :::

- **[`pixi shell-hook`][pixi-cli-shell-hook]** - Print shell activation commands (useful for scripting)
  ```bash
  eval "$(pixi shell-hook)"
  ```

### Environment Information
- **[`pixi info`][pixi-cli-info]** - Display environment and system information
  ```bash
  pixi info
  ```

  :::{note} Example pixi info output
  :class: dropdown

     ```shell
   (biautils) [<firstname>.<lastname>@compute-node compmicro-biautils-env]$ pixi info
   System
   ------------
          Pixi version: 0.45.0
              Platform: linux-64
      Virtual packages: __unix=0=0
                      : __linux=4.18.0=0
                      : __glibc=2.28=0
                      : __cuda=12.7=0
                      : __archspec=1=zen2
             Cache dir: /home/<firstname>.<lastname>/.cache/rattler/cache
          Auth storage: /home/<firstname>.<lastname>/.rattler/credentials.json
      Config locations: No config files found

   Global
   ------------
               Bin dir: /home/<firstname>.<lastname>/.pixi/bin
       Environment dir: /home/<firstname>.<lastname>/.pixi/envs
          Manifest dir: /home/<firstname>.<lastname>/.pixi/manifests/pixi-global.toml

   Workspace
   ------------
                  Name: biautils
               Version: 0.2.0
         Manifest file: /hpc/mydata/<firstname>.<lastname>/comp-micro/compmicro-biautils-env/pixi.toml
          Last updated: 15-08-2025 15:10:37

  Environments
  ------------
          Environment: default
             Features: default
             Channels: conda-forge, nvidia, pytorch, numba, rapidsai
     Dependency count: 7
         Dependencies: python, scipy, cupy, cucim, pytorch-cuda, catboost, scikit-learn
    PyPI Dependencies: napari, napari-iohub, biahub, ultrack, waveorder, viscy, rich, biautils
     Target platforms: linux-64
  System requirements: cuda = "12"
                Tasks: interactive-docs, env-info, build-docs
  ```
  :::

- **[`pixi tree`][pixi-cli-tree]** - Show the dependency tree for installed packages
  ```bash
  pixi tree
  ```

### Pixi Tasks

[Pixi tasks][pixi-tasks-docs] provide a convenient way to run common workflows and commands within your environment. Tasks are defined in the `pixi.toml` file and can be executed using `pixi run <task-name>`.

The biautils environment includes several predefined tasks:

- **`pixi run env-info`** - Display detailed environment and package information
  ```bash
  pixi run env-info
  ```

- **`pixi run start-napari`** - Launch napari image viewer
  ```bash
  pixi run start-napari
  ```

You can see all available tasks by running:
```bash
pixi task list
```

Tasks make it easy to run complex commands without remembering exact syntax and ensure consistency across different users and environments.

If you'd like additional tasks added to the environment, please [create an issue on GitHub][cmbiautils-env-issues] with your request.


## Bruno-Specific Notes

- **Module Loading**: Always load the pixi module before using pixi commands: `module load pixi`
- **Storage**: Pixi environments are stored in `/hpc/mydata/<firstname>.<lastname>/compmicro-biautils-env/.pixi/envs/` or wherever you decide to install the repository. Consider storage quotas when choosing installation locations, generally `/hpc/mydata/<firstname>.<lastname>/` is the best spot.
- **Job Submission**: When submitting jobs that use the `biautils` environment, ensure your job script loads the pixi module and activates the environment appropriately.
- **HPC Resources**: For comprehensive Bruno cluster documentation, including job submission, storage systems, and best practices, visit: [hpc.czbiohub.org](https://hpc.czbiohub.org)

## Next Steps

Once your environment is installed and verified:

1. **Explore the tools**: Try launching napari with `pixi run napari`
2. **Run analysis scripts**: Use `pixi run python your_script.py` to execute analysis code
3. **Development workflow**: Use `pixi shell` for interactive development sessions
4. **Check available commands**: Run `pixi run env_version` to see environment details
5. Found a bug? Want a feature? Make an [issue over on the Github Repository][cmbiautils-env-issues]!

<!-- LINKS -->
[biahub-gh]: https://github.com/czbiohub-sf/biahub
[waveorder-gh]: https://github.com/mehta-lab/waveorder
[ultrack-gh]: https://github.com/royerlab/ultrack
[iohub-gh]: https://github.com/czbiohub-sf/iohub
[pixi-docs]: https://pixi.sh/latest/
[cmbiautils-env-releases]: https://github.com/czbiohub-sf/compmicro-biautils-env/releases
[pixi-cli-info]: https://pixi.sh/latest/reference/cli/pixi/info/
[pixi-cli-shell]: https://pixi.sh/latest/reference/cli/pixi/shell/
[pixi-cli-install]: https://pixi.sh/latest/reference/cli/pixi/install/
[pixi-cli-clean]: https://pixi.sh/latest/reference/cli/pixi/clean/
[pixi-cli-shell-hook]: https://pixi.sh/latest/reference/cli/pixi/shell-hook/
[pixi-cli-tree]: https://pixi.sh/latest/reference/cli/pixi/tree/
[pixi-cli-run]: https://pixi.sh/latest/reference/cli/pixi/run/
[pixi-tasks-docs]: https://pixi.sh/latest/workspace/advanced_tasks/
[cmbiautils-env-issues]: https://github.com/czbiohub-sf/compmicro-biautils-env/issues

