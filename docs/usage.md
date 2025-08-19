# Usage

This guide covers how to use the **biautils** computational microscopy environment after installation, including environment verification, command reference, and best practices for the Bruno HPC cluster.

## Environment Verification

After installation, verify your environment is working correctly:

::::{tab-set}
:::{tab-item} Default Environment
:sync: env-default

**Check the environment version:**
```{code} shell
:label: verify-default-version
:caption: Check default environment version
pixi run env-info
```

**Example output:**
```{code} shell
:label: example-default-env-info
:caption: Example `pixi run env-info` output (default environment)
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

**Verify package installation:**
```{code} shell
:label: verify-default-packages
:caption: List installed packages in default environment
pixi list
```

**Open Napari:**
```{code} shell
:label: launch-napari-default
:caption: Launch Napari from default environment
pixi run start-napari
```
:::

:::{tab-item} Viz Environment
:sync: env-viz

**Check the environment version:**
```{code} shell
:label: verify-viz-version
:caption: Check viz environment version
pixi run -e viz env-info
```

**Example output:**
```{code} shell
:label: example-viz-env-info
:caption: Example `pixi run -e viz env-info` output (viz environment)
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

**Verify package installation:**
```{code} shell
:label: verify-viz-packages
:caption: List installed packages in viz environment
pixi list -e viz
```

**Open Napari:**
```{code} shell
:label: launch-napari-viz
:caption: Launch Napari from viz environment
pixi run -e viz start-napari
```
:::
::::

## Pixi CLI Command Reference

Once you have pixi installed and your environment set up, here are the key commands for managing your biautils environment:

### Environment Management
- **[`pixi install`][pixi-cli-install]** - Install or update the environment based on `pixi.toml`

  ```{code} shell
  :label: pixi-install-cmd
  :caption: Install environment with pixi
  pixi install
  ```

- **[`pixi clean`][pixi-cli-clean]** - Clean cached files and temporary data
  ```{code} shell
  :label: pixi-clean-cmd
  :caption: Clean pixi cache and temporary data
  pixi clean
  pixi clean cache  # Clean only the package cache
  ```

### Environment Activation
- **[`pixi shell`][pixi-cli-shell]** - Start an interactive shell and activate the environment

  ```{code} shell
  :label: pixi-shell-cmd
  :caption: Start interactive shell with environment
  pixi shell
  ```

  :::{note} Example pixi shell output
  :class: dropdown

     ```{code} shell
     :label: pixi-shell-example
     :caption: Example pixi shell activation
   [<userfirstname>.<userlastname?@compute-node compmicro-biautils-env]$ pixi shell

   (biautils) [<userfirstname>.<userlastname?@compute-node compmicro-biautils-env]$
     ```
  Note that this looks quite a bit like activating an Anaconda environment!
  :::

- **[`pixi shell-hook`][pixi-cli-shell-hook]** - Print shell activation commands (useful for scripting)
  ```{code} shell
  :label: pixi-shell-hook-cmd
  :caption: Use shell hook for scripting
  eval "$(pixi shell-hook)"
  ```

### Environment Information
- **[`pixi info`][pixi-cli-info]** - Display environment and system information
  ```{code} shell
  :label: pixi-info-cmd
  :caption: Display environment information
  pixi info
  ```

  :::{note} Example pixi info output
  :class: dropdown

    ```shell
    System
    ------------
        Pixi version: 0.52.0
            Platform: linux-64
    Virtual packages: __unix=0=0
                    : __linux=4.18.0=0
                    : __glibc=2.28=0
                    : __cuda=12.7=0
                    : __archspec=1=zen2
            Cache dir: /home/<userfirstname>.<userlastname>/.cache/rattler/cache
        Auth storage: /home/<userfirstname>.<userlastname>/.rattler/credentials.json
    Config locations: No config files found

    Global
    ------------
                Bin dir: /home/<userfirstname>.<userlastname>/.pixi/bin
        Environment dir: /home/<userfirstname>.<userlastname>/.pixi/envs
        Manifest dir: /home/<userfirstname>.<userlastname>/.pixi/manifests/pixi-global.toml

    Workspace
    ------------
                Name: biautils
                Version: 0.2.0
        Manifest file: /hpc/mydata/<userfirstname>.<userlastname>/comp-micro/compmicro-biautils-env/pixi.toml
        Last updated: 18-08-2025 17:52:45

    Environments
    ------------
            Environment: default
            Features: viz, ml, default
            Solve group: main
            Channels: conda-forge, nvidia, pytorch, numba, rapidsai
    Dependency count: 8
        Dependencies: ffmpeg, scipy, cupy, cucim, pytorch-cuda, catboost, scikit-learn, python
    PyPI Dependencies: napari, napari-iohub, napari-ome-zarr, napari-animation, biahub, ultrack, waveorder, viscy, biautils, iohub, rich
    Target platforms: linux-64
        Prefix location: /hpc/mydata/<userfirstname>.<userlastname>/comp-micro/compmicro-biautils-env/.pixi/envs/default
    System requirements: cuda = "12"
                Tasks: start-napari, env-info

            Environment: viz
            Features: viz, default
            Solve group: main
            Channels: conda-forge, nvidia, pytorch, numba, rapidsai
    Dependency count: 2
        Dependencies: ffmpeg, python
    PyPI Dependencies: napari, napari-iohub, napari-ome-zarr, napari-animation, biautils, iohub, rich
    Target platforms: linux-64
        Prefix location: /hpc/mydata/<userfirstname>.<userlastname>/comp-micro/compmicro-biautils-env/.pixi/envs/viz
    System requirements: cuda = "12"
                Tasks: start-napari, env-info

            Environment: test
            Features: viz, ml, test, default
            Solve group: main
            Channels: conda-forge, nvidia, pytorch, numba, rapidsai
    Dependency count: 9
        Dependencies: ffmpeg, scipy, cupy, cucim, pytorch-cuda, catboost, scikit-learn, pytest, python
    PyPI Dependencies: napari, napari-iohub, napari-ome-zarr, napari-animation, biahub, ultrack, waveorder, viscy, biautils, iohub, rich
    Target platforms: linux-64
        Prefix location: /hpc/mydata/<userfirstname>.<userlastname>/comp-micro/compmicro-biautils-env/.pixi/envs/test
    System requirements: cuda = "12"
                Tasks: start-napari, env-info, tests
    ```
  :::

- **[`pixi tree`][pixi-cli-tree]** - Show the dependency tree for installed packages
  ```{code} shell
  :label: pixi-tree-cmd
  :caption: Show dependency tree
  pixi tree
  ```

## Pixi Tasks

[Pixi tasks][pixi-tasks-docs] provide a convenient way to run common workflows and commands within your environment. Tasks are defined in the `pixi.toml` file and can be executed using `pixi run <task-name>`.

The biautils environment includes several predefined tasks:

::::{tab-set}
:::{tab-item} Default Environment
:sync: env-default

**Display environment information:**
```{code} shell
:label: pixi-run-env-info-default
:caption: Display environment information (default)
pixi run env-info
```

**Launch Napari image viewer:**
```{code} shell
:label: pixi-run-napari-default
:caption: Launch Napari image viewer (default)
pixi run start-napari
```

**Run Python scripts:**
```{code} shell
:label: pixi-run-python-default
:caption: Run Python scripts in default environment
pixi run python your_analysis_script.py
```
:::

:::{tab-item} Viz Environment
:sync: env-viz

**Display environment information:**
```{code} shell
:label: pixi-run-env-info-viz
:caption: Display environment information (viz)
pixi run -e viz env-info
```

**Launch Napari image viewer:**
```{code} shell
:label: pixi-run-napari-viz
:caption: Launch Napari image viewer (viz)
pixi run -e viz start-napari
```

**Run Python scripts:**
```{code} shell
:label: pixi-run-python-viz
:caption: Run Python scripts in viz environment
pixi run -e viz python your_viz_script.py
```

We recommend only writing scripts for creating movies or other Napari related workflows in the `viz` environment.
:::
::::

You can see all available tasks by running:
```{code} shell
:label: pixi-task-list
:caption: List available pixi tasks
pixi task list
```

Tasks make it easy to run complex commands without remembering exact syntax and ensure consistency across different users and environments.

## Bruno HPC Cluster Usage

### Cluster-Specific Notes

- **Module Loading**: Always load the pixi module before using pixi commands: `module load pixi`
- **Storage**: Pixi environments are stored in `/hpc/mydata/<userfirstname>.<userlastname?/compmicro-biautils-env/.pixi/envs/` or wherever you decide to install the repository. Consider storage quotas when choosing installation locations, generally `/hpc/mydata/<userfirstname>.<userlastname>/` is the best spot.
- **Job Submission**: When submitting jobs that use the `biautils` environment, ensure your job script loads the pixi module and activates the environment appropriately.
- **HPC Resources**: For comprehensive Bruno cluster documentation, including job submission, storage systems, and best practices, visit: [hpc.czbiohub.org](https://hpc.czbiohub.org)

## Contribute

Found a bug? Want some more dependencies or environments or tasks? Make an [issue over on the Github Repository][cmbiautils-env-issues]!

<!-- LINKS -->
[pixi-cli-info]: https://pixi.sh/latest/reference/cli/pixi/info/
[pixi-cli-shell]: https://pixi.sh/latest/reference/cli/pixi/shell/
[pixi-cli-install]: https://pixi.sh/latest/reference/cli/pixi/install/
[pixi-cli-clean]: https://pixi.sh/latest/reference/cli/pixi/clean/
[pixi-cli-shell-hook]: https://pixi.sh/latest/reference/cli/pixi/shell-hook/
[pixi-cli-tree]: https://pixi.sh/latest/reference/cli/pixi/tree/
[pixi-cli-run]: https://pixi.sh/latest/reference/cli/pixi/run/
[pixi-tasks-docs]: https://pixi.sh/latest/workspace/advanced_tasks/
[cmbiautils-env-issues]: https://github.com/czbiohub-sf/compmicro-biautils-env/issues
