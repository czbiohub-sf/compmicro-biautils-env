# compmicro-biautils-env
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

### Pip
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
We welcome contributions! Please see the [Contributing guide](./CONTRIBUTING.MD)
