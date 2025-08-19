# Installation

This document provides installation instructions for the **biautils** computational microscopy environment, specifically designed for use on the Bruno HPC cluster at CZ Biohub San Francisco.

## Prerequisites

- Access to the Bruno HPC cluster
- Basic command line knowledge
- Git access to the repository

## Installation with Pixi

Pixi is the recommended method for installing and managing the biautils environment on Bruno. Pixi provides robust environment management with automatic dependency resolution.

### How Pixi Environments Work

Pixi creates isolated environments in the `compmicro-biautils-env/.pixi/envs` directory that contain:
- Standard directories (`bin`, `lib`, `include`) with all required packages
- Automatic PATH configuration and environment variable setup
- Package-specific activation scripts
- Metadata for environment validation and updates

If you'd like a deeper dive, take a look at the following article: [Understanding Pixi][understanding-pixi].

### Installation Steps

1. **Load the pixi module on Bruno:**

   ```{code} shell
   :label: load-pixi-module
   :caption: Load pixi module on Bruno
   module load pixi
   ```

   ```{code} shell
   :label: go-to-mydata
   :caption: Make sure to be in your `/mydata/<userfirstname>.<userlastname>` Directory
   cd /hpc/mydata/<userfirstname>.<userlastname>
   ```

2. **Clone the repository:**

   ::::{tab-set}
   :::{tab-item} Git
   :sync: git-clone

   ```{code} shell
   :label: clone-repo-git-install
   :caption: Clone repository using git
   git clone https://github.com/czbiohub-sf/compmicro-biautils-env.git
   cd compmicro-biautils-env
   ```
   :::

   :::{tab-item} GitHub CLI
   :sync: gh-cli

   ```{code} shell
   :label: clone-repo-gh-install
   :caption: Clone repository using GitHub CLI
   gh repo clone czbiohub-sf/compmicro-biautils-env
   cd compmicro-biautils-env
   ```
   :::
   ::::

3. **Checkout the desired version:**

   ```{code} shell
   :label: checkout-version
   :caption: Checkout desired release version
   git checkout v${RELEASE_VERSION}
   ```

   See available versions in the [releases][cmbiautils-env-releases].

4. **Install the environment:**

   ::::{tab-set}
   :::{tab-item} Default Environment
   :sync: env-default

   ```{code} shell
   :label: install-default-full
   :caption: Install default environment (full suite)
   pixi install
   ```

   Installs the complete computational suite with both visualization and ML features.
   :::

   :::{tab-item} Viz Environment
   :sync: env-viz

   ```{code} shell
   :label: install-viz-full
   :caption: Install visualization environment only
   pixi install -e viz
   ```

   Installs only the lightweight visualization environment with Napari tools.
   :::
   ::::

5. **Activate and use the environment:**

   ::::{tab-set}
   :::{tab-item} Default Environment
   :sync: env-default

   **Start a shell with the environment activated:**
   ```{code} shell
   :label: activate-default-shell
   :caption: Activate default environment shell
   pixi shell
   ```

   **Or run commands directly in the environment:**
   ```{code} shell
   :label: run-default-commands
   :caption: Run commands in default environment
   pixi run start-napari
   pixi run python your_analysis_script.py
   ```
   :::

   :::{tab-item} Viz Environment
   :sync: env-viz

   **Start a shell with the environment activated:**
   ```{code} shell
   :label: activate-viz-shell
   :caption: Activate viz environment shell
   pixi shell -e viz
   ```

   **Or run commands directly in the environment:**
   ```{code} shell
   :label: run-viz-commands
   :caption: Run commands in viz environment
   pixi run -e viz start-napari
   ```
   :::
   ::::

## Next Steps

For detailed usage instructions and a set of key command references, see the **[Usage Guide](./usage.md)**.

<!-- LINKS -->
[pixi-docs]: https://pixi.sh/latest/
[cmbiautils-env-releases]: https://github.com/czbiohub-sf/compmicro-biautils-env/releases
[understanding-pixi]: ./understanding_pixi.md
