# Understanding Pixi

:::{note} TL;DR
**Bottom line:** Pixi uses a hierarchical architecture where **Workspaces** contain **Environments** (built from reusable **Features**), **Solve Groups** ensure identical versions across related environments, and **Dependencies** come from both conda and PyPI. This enables you to have different environments for different use cases like:
- a minimal GUI environment for visualization
- a full HPC environment for computation
- a testing environment

all while maintaining consistent package versions across environments.
:::

Pixi revolutionizes Python package management by introducing a **project-centric architecture** where **workspaces**, **environments**, **features**, **solve groups**, and **dependencies** work together in a sophisticated hierarchy. Unlike traditional package managers that manage individual environments, Pixi orchestrates entire projects through modular, composable configurations that ensure consistency and reproducibility across development, testing, and production deployments.

## The hierarchical structure that powers Pixi

```
📦 biautils Workspace (pixi.toml)
├── 🔧 Solve Groups (coordinate resolution across environments)
│   └── main: [default, viz, test] → ensures version consistency
│
├── 🌍 Environments (isolated execution contexts)
│   ├── default → combines [viz, ml] features (full HPC environment)
│   ├── viz → combines [viz] feature (GUI-only environment)
│   └── test → combines [viz, ml, test] features (testing environment)
│
├── 🧩 Features (modular dependency collections)
│   ├── (implicit default) → core runtime: python, biautils, iohub, rich
│   ├── viz → visualization tools: napari, ffmpeg, GUI dependencies
│   ├── ml → machine learning: pytorch-cuda, scipy, cupy, viscy, ultrack
│   └── test → testing utilities: pytest
│
└── 📚 Dependencies (actual packages)
    ├── conda packages: python, scipy, cupy, pytorch-cuda, ffmpeg, pytest
    └── PyPI packages: napari, biautils, iohub, viscy, ultrack, biahub
```

Pixi's architecture follows a clear containment hierarchy where each level serves a specific purpose. At the top, **workspaces** act as project containers, defined by a `pixi.toml` manifest file that declares the project's entire dependency and environment strategy. Within workspaces, **environments** represent isolated execution contexts - similar to virtual environments but more sophisticated. These environments are constructed from **features**, which are modular collections of dependencies, tasks, and configurations that can be mixed and matched. **Solve groups** coordinate dependency resolution across multiple environments, ensuring version consistency. At the foundation, **dependencies** from both conda and PyPI ecosystems provide the actual packages.

This hierarchy creates a flow where features define modular requirements, environments combine features into installable contexts, solve groups ensure cross-environment compatibility, and the lock file captures exact resolutions for perfect reproducibility. The architecture enables **composition over configuration** - rather than duplicating dependency lists across environments, you define reusable features that combine intelligently.

The workspace structure physically manifests in the filesystem with a `.pixi` directory containing isolated environments, each with its own conda-style directory structure. The `pixi.lock` file, automatically generated and updated, contains platform-specific dependency resolutions with cryptographic hashes, ensuring identical environments across machines and CI/CD pipelines.

## Features enable modular, reusable configurations

Features represent Pixi's most innovative concept - **modular dependency sets** that transcend simple package lists. Each feature can include conda dependencies, PyPI dependencies, executable tasks, platform restrictions, system requirements, channels, and activation scripts. When you define a feature for "testing" with pytest and related tools, or "cuda" with GPU-specific packages, these become reusable building blocks that any environment can incorporate.

Consider the biautils computational microscopy project that needs different configurations for visualization workstations, HPC compute nodes, and testing environments. Instead of maintaining three separate dependency lists with significant overlap, you define core runtime dependencies (Python, biautils, iohub), then create specialized features for visualization (napari GUI tools), machine learning (CUDA-accelerated compute libraries), and testing (pytest utilities). Each feature can specify platform-specific requirements and CUDA system dependencies.

```toml
# Visualization feature for GUI workstations
[feature.viz.dependencies]
ffmpeg = "*"  # Required for napari-animation

[feature.viz.pypi-dependencies]
napari = { version = ">=0.6.4, <0.7", extras = ["pyqt6"] }
napari-iohub = { git = "https://github.com/czbiohub-sf/napari-iohub" }
napari-ome-zarr = { version = ">=0.6.1" }
napari-animation = { version = ">=0.0.9" }

# ML/AI feature for compute environments
[feature.ml.dependencies]
scipy = "<1.16"           # biahub compatibility constraint
pytorch-cuda = "==12.4"   # CUDA 12 acceleration
cupy = "*"               # GPU-accelerated NumPy
cucim = "*"              # GPU-accelerated image processing

[feature.ml.pypi-dependencies]
viscy = ">=0.3.2"        # Virtual staining with computer vision
ultrack = { git = "https://github.com/royerlab/ultrack" }  # Cell tracking
```

Features compose through **union semantics** for dependencies and tasks, but **intersection semantics** for platforms. When an environment combines multiple features, Pixi merges their dependencies intelligently, resolving conflicts and creating a unified dependency tree. This composition enables sophisticated patterns like having base features extended by specialized features, or orthogonal features that add independent capabilities.

## Environments orchestrate feature combinations

Environments transform abstract feature definitions into **concrete, installable contexts**. Each environment specifies which features to include and optionally assigns a solve group for coordinated dependency resolution. The default environment, created automatically, provides the primary development context, while named environments serve specific purposes like testing, production deployment, or platform-specific builds.

The power of environments emerges from their ability to **combine features flexibly**. A development environment might include features for testing, documentation, and linting tools, while a production environment uses only the core runtime dependencies from the default feature. A CI testing environment could combine testing features with specific Python version features to create a test matrix. Each environment maintains complete isolation - changes to one environment don't affect others, even when they share common features.

```toml
[environments]
# Full HPC environment with visualization and ML capabilities
default = { features = ["viz", "ml"], solve-group = "main" }
# Minimal visualization environment for GUI workstations
viz = { features = ["viz"], solve-group = "main" }
# Complete testing environment with all features
test = { features = ["viz", "ml", "test"], solve-group = "main" }
```

Environments also support the `no-default-feature` flag, which prevents automatic inclusion of the default feature dependencies. This enables creation of minimal environments for specific tasks like linting or documentation building without pulling in the full application dependency tree.

## Solve groups ensure cross-environment consistency

Solve groups represent Pixi's solution to a critical problem in software deployment: **ensuring identical dependency versions** between related environments. When environments share a solve group, Pixi's resolver treats them as a single unified environment during dependency resolution, then creates specific subsets for each actual environment. This guarantees that your production environment uses exactly the same package versions that were tested in your test environment.

The solve group mechanism works by collecting all dependencies from all environments in the group, resolving them together to find a compatible set of versions, then installing only the required subset in each environment. **This eliminates the "works on my machine" problem** by ensuring that if a package appears in multiple environments within a solve group, it will have identical versions across all of them.

For computational microscopy workflows, this pattern proves invaluable. In biautils, all environments (default, viz, test) share the "main" solve group, ensuring that when you test image analysis pipelines in the test environment, the visualization environment uses exactly the same versions of core libraries like numpy, scipy, and pytorch-cuda. This eliminates issues where a pipeline works in testing but fails in visualization due to subtle version differences in underlying dependencies. The test environment includes additional pytest tools while maintaining identical core package versions across all deployment contexts.

## Sophisticated dependency resolution across ecosystems

Pixi implements a **"conda-first" resolution strategy** that seamlessly integrates packages from both conda and PyPI ecosystems. The resolution process begins with conda packages, using the Rust-based `rattler` library with the `resolvo` SAT solver to find compatible versions. These resolved conda packages then become locked constraints for the PyPI resolution phase, where the `uv` library resolves remaining Python-specific packages.

This dual-ecosystem approach provides several advantages. **Binary packages from conda install instantly** without compilation, system-level dependencies get proper management through conda's comprehensive packaging, and PyPI packages fill gaps for Python-specific tools not available in conda repositories. The lock file captures both conda and PyPI resolutions with platform-specific details, ensuring reproducibility across different operating systems and architectures.

The resolution architecture handles complex scenarios like packages available in both ecosystems (conda takes precedence), build dependencies for compiled packages, and platform-specific requirements. When conflicts arise, Pixi's sophisticated solver finds compatible versions across the entire dependency tree, considering system requirements, platform constraints, and channel priorities.

## Practical patterns for complex projects

Real-world projects demonstrate how these concepts work together. **A web application with multiple deployment targets** might use solve groups to ensure production-test parity, features to separate development tools from runtime dependencies, and environments to create specific deployment configurations. The workspace configuration defines common channels and platforms, while features add specialized capabilities like database drivers or monitoring tools.

**Multi-language projects** leverage Pixi's conda foundation to manage non-Python dependencies seamlessly. A data science project might include R, Julia, and system libraries alongside Python packages, all resolved consistently. Features can encapsulate language-specific tools, while environments combine them for polyglot development workflows.

**Platform-specific optimizations** emerge naturally from the feature system. CUDA-accelerated environments for Linux and Windows, Apple Silicon optimizations with MLX, and CPU-only fallbacks can coexist in the same project. The platform restrictions on features ensure each environment only includes compatible packages, while solve groups maintain version consistency across platforms where packages overlap.

## Conclusion

Pixi's interconnected architecture represents a fundamental shift in package management philosophy, moving from isolated environment management to **holistic project orchestration**. The hierarchy from workspaces through environments and features to dependencies creates a flexible yet rigorous system for managing complex software projects. Solve groups ensure reproducibility across deployment stages, while the dual-ecosystem resolution provides access to both binary conda packages and the full PyPI repository.

The true power emerges from how these concepts compose:

- features provide modularity and reuse,
- environments enable targeted configurations,
- solve groups guarantee consistency,
- the workspace ties everything together with platform-aware, reproducible dependency resolution.

This architecture scales from simple single-environment projects to complex multi-platform, multi-language applications while maintaining the simplicity and reliability that modern development demands.

## Further Reading

- [Oregon State University Research HPC Documentation][oregon-state-pixi]
- [New Mexico State University HPC Documentation][new-mexico-pixi]
- [Pixi Blog Post for Scientific Software Workflows][pixi-blog]


[oregon-state-pixi]: https://docs.hpc.oregonstate.edu/cqls/software/conda/pixi/
[new-mexico-pixi]: https://hpc.nmsu.edu/discovery/software/sstack/types/pixi/
[pixi-blog]: https://prefix.dev/blog/pixi_for_scientists
