"""biautils compute environment for computational microscopy at CZBiohub SF."""

import sys
from importlib.metadata import PackageNotFoundError, version

MAIN_DEPENDENCIES = [
    "napari",
    "napari-ome-zarr",
    "napari-animation",
    "napari-iohub",
    "ipykernel",
    "biahub",
    "waveorder",
    "viscy",
]

def get_package_version(package_name: str) -> str | None:
    """Get the version of a package if it's installed."""
    try:
        return version(package_name)
    except PackageNotFoundError:
        return None

def print_environment_info():
    """Print biautils version and main dependency versions."""
    try:
        # Get biautils version
        biautils_version = version("biautils")
        print(f"🐸 biautils version: {biautils_version}")

        # Print main dependency versions
        print("📦 Main dependencies:")
        for dep in MAIN_DEPENDENCIES:
            dep_version = get_package_version(dep)
            if dep_version:
                print(f"   {dep}: {dep_version}")
            else:
                print(f"   {dep}: not installed")

        print(f"🐍 Python version: {sys.version.split()[0]}")
        print("-" * 50)

    except PackageNotFoundError as e:
        print(f"⚠️  Could not retrieve environment info: {e}")
