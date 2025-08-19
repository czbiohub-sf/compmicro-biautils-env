# CompMicro Biautils Env

+++ {"part": "abstract"}
The CompMicro Biautils Environment is a comprehensive computational microscopy platform for $N$-dimensional bioimaging data analysis. This integrated environment combines packages for high-throughput reconstruction, label-free imaging, cell tracking, I/O, and visualization.

Choose the full computational suite or a lightweight Napari-focused visualization environment. Optimized for the Bruno HPC cluster at CZ Biohub San Francisco with GPU acceleration (CUDA 12) and parallel processing for large-scale microscopy datasets.
+++

Environment for N-dimensional microscopy data analysis and visualization.

Includes the following packages:
- [`napari`][napari-gh]: *Multi-dimensional image viewer with specialized plugins for scientific imaging.*
- [`napari-ome-zarr`][napari-ome-zarr-gh]: *Napari plugin for reading and writing OME-Zarr datasets.*
- [`napari-animation`][napari-animation-gh]: *Napari plugin for creating animations and movies from image data.*
- [`napari-iohub`][napari-iohub-gh]: *Napari plugin for interactive visualization of high-dimensional microscopy datasets.*
- [`biahub`][biahub-gh]: *Bio-image analysis hub for high-throughput reconstruction of multimodal microscopy datasets on HPC clusters using OME-ZARR workflows.*
- [`waveorder`][waveorder-gh]: *A generalist framework for label-agnostic computational microscopy enabling quantitative imaging of biomolecular architecture with diffraction-limited resolution.*
- [`ultrack`][ultrack-gh]: *Versatile and scalable cell tracking software for 2D/3D timelapse recordings with robust performance under segmentation uncertainty.*
- [`viscy`][viscy-gh]: *Deep learning pipeline for computational microscopy specializing in virtual staining, representation learning, and semantic segmentation of single-cell phenotypes.*
- [`iohub`][iohub-gh]: *Pythonic and parallelizable I/O library for N-dimensional imaging data with unified support for OME-Zarr, Micro-Manager TIFF, and custom Biohub microscope formats.*

Maintained by the Computational Microscopy platform at CZ Biohub San Francisco. Available on the Bruno HPC cluster via [`pixi`][pixi-docs].


## Getting Started

First clone the repository, we recommend you clone this in `/hpc/mydata/<userfirstname>.<userlastname>/` to avoid running out of space in your `${HOME}` directory.

::::{tab-set}
:::{tab-item} Git
:sync: git-clone

```{code} shell
:label: clone-repo-git
:caption: Clone the repository using git
git clone https://github.com/czbiohub-sf/compmicro-biautils-env.git
```
:::

:::{tab-item} GitHub CLI
:sync: gh-cli

```{code} shell
:label: clone-repo-gh
:caption: Clone the repository using GitHub CLI
gh repo clone czbiohub-sf/compmicro-biautils-env
```
:::
::::

You will need to have the `pixi` module loaded on `Bruno`.

```{code} shell
:linenos:
:label: load-pixi
:caption: Load pixi module on Bruno
module load pixi
```

### Install the Environment
Install the environments with Pixi:

::::{tab-set}
:::{tab-item} Default Environment
:sync: env-default

```{code} shell
:label: install-default-env
:caption: Install default environment
pixi install
```

Installs the default environment (includes both viz and ml features). This is the full computational suite with all packages available.
:::

:::{tab-item} Viz Environment
:sync: env-viz

```{code} shell
:label: install-viz-env
:caption: Install visualization environment
pixi install -e viz
```

Installs only the lightweight visualization environment with Napari tools. Perfect for Napari-only workflows.
:::
::::

Note: Installation is optional as `pixi run` and `pixi shell` will automatically install dependencies when needed.

### Activate the Environment

::::{tab-set}
:::{tab-item} Default Environment
:sync: env-default

Activate the default environment (includes both viz and ml features):

```{code} shell
:label: activate-default
:caption: Activate default environment
pixi shell
```

Check what's installed:
```{code} shell
:label: check-default-env
:caption: Check installed packages in default environment
pixi run env-info
```

**Example output:**

```{code} shell
:label: pixi-env-info-output-default
:caption: Example pixi run env-info output (default environment)
╭───────────────────────────────────────────────────────────────────────╮
│ 🐸 biautils version: 0.0.0.post11.dev0+bacc161 | 🐍 Python: 3.11.0    │
╰───────────────────────────────────────────────────────────────────────╯
📦 Dependencies
├── 🦠 Napari
│   ├── ✅ napari (0.6.4)
│   ├── ✅ napari-ome-zarr (0.6.1)
│   ├── ✅ napari-animation (0.0.9)
│   └── ✅ napari-iohub (0.1.0a1.dev1+g8ccff7c86)
├── 🔬 Scientific Computing
│   ├── ✅ scipy (1.15.2)
│   ├── ✅ numpy (2.2.6)
│   └── ✅ scikit-learn (1.7.1)
├── 🚀 Pipeline and I/O
│   ├── ✅ biahub (0.1.0)
│   └── ✅ iohub (0.2.0)
├── 🧠 AI/ML
│   ├── ✅ ultrack (0.7.0rc1)
│   ├── ✅ catboost (1.2.8)
│   └── ✅ viscy (0.3.2)
├── 🔍 Image Processing
│   ├── ✅ waveorder (3.0.0a1)
│   ├── ✅ viscy (0.3.2)
│   └── ✅ cucim (25.8.0)
├── ⚡ GPU Acceleration
│   └── ✅ cupy (13.5.1)
└── 🛠️ Development
    └── ✅ ipykernel (6.30.1)
╭───────────────────────────────────────────────────────────────────────╮
│ 📊 Summary: 17/17 packages installed ✨ All dependencies available!   │
╰───────────────────────────────────────────────────────────────────────╯
```
:::

:::{tab-item} Viz Environment
:sync: env-viz

Activate the visualization environment (Napari tools only):

```{code} shell
:label: activate-viz
:caption: Activate viz environment
pixi shell -e viz
```

Check what's installed:
```{code} shell
:label: check-viz-env
:caption: Check installed packages in viz environment
pixi run -e viz env-info
```

**Example output:**

```{code} shell
:label: pixi-env-info-output-viz
:caption: Example pixi run -e viz env-info output (viz environment)
╭───────────────────────────────────────────────────────────────────────╮
│ 🐸 biautils version: 0.0.0.post11.dev0+bacc161 | 🐍 Python: 3.11.0    │
╰───────────────────────────────────────────────────────────────────────╯
📦 Dependencies
├── 🦠 Napari
│   ├── ✅ napari (0.6.4)
│   ├── ✅ napari-ome-zarr (0.6.1)
│   ├── ✅ napari-animation (0.0.9)
│   └── ✅ napari-iohub (0.1.0a1.dev1+g8ccff7c86)
├── 🔬 Scientific Computing
│   ├── ✅ scipy (1.15.2)
│   ├── ✅ numpy (2.2.6)
│   └── ❌ scikit-learn (not installed)
├── 🚀 Pipeline and I/O
│   ├── ❌ biahub (not installed)
│   └── ✅ iohub (0.2.0)
├── 🧠 AI/ML
│   ├── ❌ ultrack (not installed)
│   ├── ❌ catboost (not installed)
│   └── ❌ viscy (not installed)
├── 🔍 Image Processing
│   ├── ❌ waveorder (not installed)
│   ├── ❌ viscy (not installed)
│   └── ❌ cucim (not installed)
├── ⚡ GPU Acceleration
│   └── ❌ cupy (not installed)
└── 🛠️ Development
    └── ✅ ipykernel (6.30.1)
╭───────────────────────────────────────────────────────────────────────╮
│ 📊 Summary: 8/17 packages installed ⚠️  9 packages missing            │
╰───────────────────────────────────────────────────────────────────────╯
```
:::
::::

...and you're good to go, have fun!

<!-- LINKS -->
[napari-gh]: https://github.com/napari/napari
[napari-ome-zarr-gh]: https://github.com/ome/napari-ome-zarr
[napari-animation-gh]: https://github.com/napari/napari-animation
[napari-iohub-gh]: https://github.com/czbiohub-sf/napari-iohub
[biahub-gh]: https://github.com/czbiohub-sf/biahub
[waveorder-gh]: https://github.com/mehta-lab/waveorder

[ultrack-gh]: https://github.com/royerlab/ultrack
[viscy-gh]: https://github.com/mehta-lab/VisCy
[iohub-gh]: https://github.com/czbiohub-sf/iohub
[pixi-docs]: https://pixi.sh/latest/
