
# compmicro-biautils-env

<div align="center">

|               |                                                                                                                                                                                                              |
| :-----------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|  **Status**   | [![Build][badge-build]][link-build] [![Tests][badge-test]][link-test] [![Documentation][badge-jupyterbook]][link-docs] |
|   **Meta**    |         [![Hatch project][badge-hatch]][link-hatch] [![Ruff][badge-ruff]][link-ruff] [![pixi][badge-pixi]][link-pixi] [![License][badge-license]][link-license]           |
|  **Package / Docker**  |                                                                                                                                                                                                              |
|               |                                                                                                                                                                                                              |

</div>

[badge-build]: https://github.com/czbiohub-sf/compmicro-biautils-env/actions/workflows/build.yaml/badge.svg
[badge-test]: https://github.com/czbiohub-sf/compmicro-biautils-env/actions/workflows/test.yaml/badge.svg
[badge-jupyterbook]: https://jupyterbook.org/badge.svg


[badge-ruff]: https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json
[badge-pixi]: https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/prefix-dev/pixi/main/assets/badge/v0.json
[badge-license]: https://img.shields.io/badge/License-BSD%203--Clause-yellow.svg
[badge-hatch]: https://img.shields.io/badge/%F0%9F%A5%9A-Hatch-4051b5.svg

[badge-pre-commit]: https://results.pre-commit.ci/badge/github/czbiohub-sf/compmicro-biautils-env/main.svg



This repo contains an environment definition and automated build for the "biautils" Python environment used for analysis of N-dimensional microscopy data. The environment is maintained by the Computational Microscopy platform at the Chan Zuckerberg Biohub - San Francisco and is available on the `bruno` high performance compute cluster.

## Loading the environment on `bruno`
If you have access to `bruno` you can load this shared environment using

```sh
module load anaconda comp_micro
conda activate biautils
```

## Checking the environment version
This environment is versioned, and a list of previous versions is available under Releases.

You can check the version of the installed environment using the env_version command, using with "pip list", or with "pip show".

```
$ env_version
biautils 0.2.0.dev3

$ pip list | grep biautils
biautils         0.2.0.dev3

$ pip show biautils
Name: biautils
Version: 0.2.0.dev3
Summary: biautils compute environment for computational microscopy at CZBiohub SF
...
```

## Installation
You can install your own copy of this environment in the following ways. See the available releases at https://github.com/czbiohub-sf/compmicro-biautils-env/releases.

### Pixi (Recommended - Cross-platform support)
```bash
# Install Pixi if you haven't already
curl -fsSL https://pixi.sh/install.sh | bash

# Clone and setup the environment
git clone git@github.com:czbiohub-sf/compmicro-biautils-env.git
cd compmicro-biautils-env
git checkout v${RELEASE_VERSION}

# Install and activate the environment
pixi install
pixi shell

# Or run commands directly
pixi run napari
```

### UV/Pip
```
python3 -m pip install git+https://github.com/czbiohub-sf/compmicro-biautils-env.git@v${RELEASE_VERSION}
```

### Conda
```
git clone git@github.com:czbiohub-sf/compmicro-biautils-env.git
cd compmicro-biautils-env
git checkout v${RELEASE_VERSION}
conda env create --file=environment.yml
```

### Docker
A docker image is automatically built using GitHub actions whenever a version tag is pushed. See the GitHub-hosted [compmicro-biautils-env](https://github.com/czbiohub-sf/compmicro-biautils-env/pkgs/container/compmicro-biautils-env) Docker repository.

To pull and run a Docker image:
```
docker run ghcr.io/czbiohub-sf/compmicro-biautils-env:v${RELEASE_VERSION}
```

### Apptainer
To run an Apptainer container created from the Docker image:
```
apptainer run docker://ghcr.io/czbiohub-sf/compmicro-biautils-env:v${RELEASE_VERSION}
```

Or to run a bash shell in Apptainer:
```
apptainer exec docker://ghcr.io/czbiohub-sf/compmicro-biautils-env:$v{RELEASE_VERSION} bash
```

## Contributing
We welcome contributions! Please see the [Contributing guide](./CONTRIBUTING.md)

<!-- done3 -->

[scverse-discourse]: https://discourse.scverse.org/
[issue-tracker]: https://github.com/czbiohub-sf/compmicro-biautils-env/issues
[changelog]: https://biautils.readthedocs.io/en/latest/changelog.html
[link-docs]: https://czbiohub-sf.github.io/compmicro-biautils-env/

[link-test]: https://github.com/czbiohub-sf/compmicro-biautils-env/actions/workflows/test.yml
[link-build]: https://github.com/czbiohub-sf/compmicro-biautils-env/actions/workflows/build.yaml
[link-ruff]: https://github.com/astral-sh/ruff
[link-pixi]: https://pixi.sh/dev/
[link-license]: https://opensource.org/licenses/BSD-3-Clause
[link-hatch]: https://github.com/pypa/hatch
[link-narwhals]: https://github.com/narwhals-dev/narwhals
[link-disucssions]: https://github.com/czbiohub-sf/compmicro-biautils-env/discussions
[link-pre-commit]: https://results.pre-commit.ci/latest/github/czbiohub-sf/compmicro-biautils-env/main
