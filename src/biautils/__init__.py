"""biautils compute environment for computational microscopy at CZBiohub SF."""

import sys
from importlib.metadata import PackageNotFoundError, version

from rich import box
from rich.console import Console
from rich.panel import Panel
from rich.tree import Tree

__all__ = ["print_environment_info"]

# Core dependencies organized by category
DEPENDENCY_CATEGORIES = {
    "🦠 Napari": [
        "napari",
        "napari-ome-zarr",
        "napari-animation",
        "napari-iohub",
    ],
    "🔬 Scientific Computing": [
        "scipy",
        "numpy",
        "scikit-learn",
    ],
    "🚀 Pipeline and I/O": [
        "biahub",
        "iohub",
    ],
    "🧠 AI/ML": [
        "ultrack",
        "catboost",
    ],
    "🔍 Image Processing": [
        "waveorder",
        "viscy",
        "cucim",
    ],
    "⚡ GPU Acceleration": [
        "cupy",
    ],
    "🛠️ Development": [
        "ipykernel",
    ],
}


def get_package_version(package_name: str) -> str | None:
    """Get the version of a package if it's installed."""
    try:
        return version(package_name)
    except PackageNotFoundError:
        return None


def get_package_status(package_name: str) -> dict[str, str]:
    """Get package status including version and installation status."""
    version_info = get_package_version(package_name)
    if version_info:
        return {"status": "✅", "version": version_info, "installed": True}
    else:
        return {"status": "❌", "version": "not installed", "installed": False}


def print_environment_info():
    """Print biautils version and main dependency versions with rich formatting."""
    console = Console()

    # Header with biautils info
    try:
        biautils_version = version("biautils")
        header = f"🐸 [bold blue]biautils[/bold blue] version: [green]{biautils_version}[/green]"
    except PackageNotFoundError:
        header = "🐸 [bold blue]biautils[/bold blue] version: [red]unknown[/red]"

    python_version = sys.version.split()[0]
    header += f" | 🐍 Python: [cyan]{python_version}[/cyan]"

    console.print(Panel(header, box=box.ROUNDED, style="bold"))

    # Create dependency tree
    tree = Tree("📦 [bold]Dependencies[/bold]", style="blue")

    for category, packages in DEPENDENCY_CATEGORIES.items():
        category_branch = tree.add(f"[bold]{category}[/bold]", style="yellow")

        for package in packages:
            status = get_package_status(package)
            if status["installed"]:
                package_text = f"{status['status']} [green]{package}[/green] ([cyan]{status['version']}[/cyan])"
            else:
                package_text = f"{status['status']} [red]{package}[/red] ([dim]{status['version']}[/dim])"
            category_branch.add(package_text)

    console.print(tree)

    # Summary panel
    total_packages = sum(len(packages) for packages in DEPENDENCY_CATEGORIES.values())
    installed_packages = sum(
        1
        for packages in DEPENDENCY_CATEGORIES.values()
        for package in packages
        if get_package_status(package)["installed"]
    )

    summary = f"📊 [bold]Summary:[/bold] {installed_packages}/{total_packages} packages installed"
    if installed_packages == total_packages:
        summary += " [green]✨ All dependencies available![/green]"
    else:
        summary += f" [yellow]⚠️  {total_packages - installed_packages} packages missing[/yellow]"

    console.print(Panel(summary, box=box.ROUNDED, style="bold"))
