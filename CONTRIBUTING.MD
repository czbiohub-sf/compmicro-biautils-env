# Contributing
Thank you for your interest in contributing to this project! Please follow these guidelines.

## Setup your development environment
Building the environment requires `pip-tools` to update the environment dependencies and the package uses `pre-commit` hooks to keep the dependencies up to date. Here is how to set that up.

### Clone the repo
```sh
git clone git@github.com:czbiohub-sf/compmicro-biautils-env.git
cd compmicro-biautils-env
```

### Create a conda environment and rebuild dependencies
Package dependencies can differ between different operating systems and different python versions. This package contain high-level dependencies in the [requirements.in](./requirements.in) file and uses `pip-tools` to generate fully-resolved environment-specific dependencies in [requirements.txt](./requirements.txt). The dependencies in [requirements.txt](./requirements.txt) are tested to work on `bruno` and should be updated for your environment.

```sh
conda create -n biautils-dev python=3.12 
conda activate biautils-dev
pip install pip-tools pre-commit
pip-compile --no-emit-options --upgrade
```

### Install the package
Install the package in dev move and setup pre-commit hooks

```sh
pip install -e ".[dev]"
pre-commit install
```

## Contributing changes
To update this environment:
* Check out the git repo and make edits
  * Update top-level Python dependencies by editing requirements.in
  * Regenerate requirements.txt from requirements.in by running "pip-compile --no-emit-options". (Requires "pip install pip-tools".)
* Commit and push/merge changes to a branch
* Tag the commit with a version identifier (`git tag vX.Y.Z`)
* Push the tag with `git push --tags` (warning this pushes ALL local tags)
* Open a Pull Request and ensure that the scheduled [GitHub actions](https://github.com/czbiohub-sf/compmicro-biautils-env/actions) succeed
* If needed, deploy the new environment to your infrastructure (e.g. by running "conda env update --file=environment.yml".) Deployment varies between sites; the CompMicro team maintains instructions for deployment on bruno [here](https://github.com/czbiohub-sf/compmicro-hpc/blob/main/hpc/setup_shared_env.md)

## Guidelines for tag names
We use semantic versioning for tag names (i.e. `vMAJOR.MINOR.PATCH`) which are then propagated to the package version names.

Increment the MAJOR version when:
* adding a new package to `requirements.in`
* removing a package from `requirements.in`
* updating the major version of a pinned package in `requirements.in`

Increment in MINOR version when:
* updating the minor or patch version of a pinned package in `requirements.in`

Increment the PATCH version when:
* creating a new tag without making updates to `requirements.in`

Use release candidates (e.g. `vX.Y.Zrc0`) during testing as needed.

## Creating a new environment
If you want to use the code in this repo as a template for creating other versioned environment, you will need to make the following changes:
* Create a new repo in GitHub. (Defining multiple environments in one GitHub repo is to be avoided because it complicates versioning and automatically building each environment separately.)
* When copying files into the new repo, be sure to include the hidden ".github/" directory and ".gitignore" file, but exclude the ".git/" directory. (A fresh ".git" directory will be creating either by `git init` or by cloning a clean repo created in GitHub.)
* Edit the following files and directories to update references to the git repo name (compmicro-biautils-env), Python package name and conda environment name (biautils), environment name. (You may want to grep to make sure there are not any others.)
  * README.md
  * pyproject.toml
  * biautils/
* Edit the Dockerfile to ensure an appropriate ENTRYPOINT is used, if any, for the new environment.
* Commit, tag, and push the updated code as described in "Creating a new release".
