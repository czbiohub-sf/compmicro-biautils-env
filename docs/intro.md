# CompMicro Biautils Env

+++ {"part": "abstract"}
The CompMicro Biautils Environment is a comprehensive computational microscopy environment designed for $N$-dimensional bioimaging data analysis. This integrated environment combines packages for high-throughput reconstruction, label-free imaging, cell tracking, and data I/O, all optimized for high-performance computing clusters. It provides both containerized deployment via Apptainer environments and Pixi virtual environments. The platform is specifically configured for the Bruno HPC cluster at CZ Biohub San Francisco, offering GPU acceleration with CUDA 12 support and parallel processing capabilities for large-scale microscopy datasets.
+++

Environment for N-dimensional microscopy data analysis.

Includes the following packages:
- [`biahub`][biahub-gh]: *Bio-image analysis hub for high-throughput reconstruction of multimodal microscopy datasets on HPC clusters using OME-ZARR workflows.*
- [`waveorder`][waveorder-gh]: *A generalist framework for label-agnostic computational microscopy enabling quantitative imaging of biomolecular architecture with diffraction-limited resolution.*
- [`ultrack`][ultrack-gh]: *Versatile and scalable cell tracking software for 2D/3D timelapse recordings with robust performance under segmentation uncertainty.*
- [`viscy`][viscy-gh]: *Deep learning pipeline for computational microscopy specializing in virtual staining, representation learning, and semantic segmentation of single-cell phenotypes.*
- [`iohub`][iohub-gh]: *Pythonic and parallelizable I/O library for N-dimensional imaging data with unified support for OME-Zarr, Micro-Manager TIFF, and custom Biohub microscope formats.*

Maintained by the Computational Microscopy platform at CZ Biohub San Francisco. Available on the Bruno HPC cluster via apptainer or locally via [`pixi`][pixi-docs].


## Getting Started

First clone the repository, we recommend you clone this in `/hpc/mydata/<firstname>.<lastname>/` to avoid running out of space in your `${HOME}` directory.

```shell
git clone https://github.com/czbiohub-sf/compmicro-biautils-env.git
```

You will need to have the `pixi` module loaded on `Bruno`.

```shell
ml pixi
```

Install the environment with Pixi

```shell
pixi install
```

Activate the environment with Pixi

```shell
pixi shell
```

(Optional) Check to see what's installed - this command displays all available packages and their versions
```shell
pixi run env-info
```

This should get you something like the following output

```{code} shell
:label: pixi-env-info-output
:caption: Example pixi run env-info output
╭───────────────────────────────────────────────────────────────────────╮
│ 🐸 biautils version: 0.0.0.post11.dev0+bacc161 | 🐍 Python: 3.11.0     │
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
│ 📊 Summary: 17/17 packages installed ✨ All dependencies available!    │
╰───────────────────────────────────────────────────────────────────────╯
```

...and you're good to go, have fun!

<!-- LINKS -->
[biahub-gh]: https://github.com/czbiohub-sf/biahub
[waveorder-gh]: https://github.com/mehta-lab/waveorder
[ultrack-gh]: https://github.com/royerlab/ultrack
[viscy-gh]: https://github.com/mehta-lab/VisCy
[iohub-gh]: https://github.com/czbiohub-sf/iohub
[pixi-docs]: https://pixi.sh/latest/
