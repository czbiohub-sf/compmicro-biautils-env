# Development

This document provides development guidelines for contributors to the biautils computational microscopy environment.

## Environment Development on Bruno

### Prerequisites for Development
- Access to Bruno HPC cluster
- Git access with write permissions to the repository
- Basic understanding of pixi and Python environments

### Development Workflow

1. **Clone the repository for development:**
   ```bash
   git clone https://github.com/czbiohub-sf/compmicro-biautils-env.git
   cd compmicro-biautils-env
   ```

2. **Load pixi and install the environment:**
   ```bash
   module load pixi
   pixi install
   ```

3. **Make your changes** to `pixi.toml` or other configuration files

4. **Test your changes:**
   ```bash
   pixi install  # Re-install after changes
   pixi shell    # Test the environment
   ```

5. **Create a pull request** with your changes

### Modifying the Environment

When adding or modifying packages in the environment:

- **Dependencies**: Add conda packages to the `[dependencies]` section
- **PyPI packages**: Add pip packages to the `[pypi-dependencies]` section
- **Version constraints**: Be mindful of compatibility, especially for CUDA packages
- **Testing**: Always test changes thoroughly on Bruno before submitting

Example of adding a new package:
```toml
[dependencies]
new-package = ">=1.0.0"

[pypi-dependencies]
new-pypi-package = ">=2.0.0"
```

### Testing on Bruno

Before submitting changes:
1. Test installation from scratch: `pixi clean && pixi install`
2. Verify all existing functionality works
3. Test new packages/features you've added
4. Run `pixi run env-info` to confirm package installation

## Building Documentation Locally

### Prerequisites and Setup

The documentation is built using [Jupyter Book 2][jupyter-book-2], which is currently **not available on conda-forge**. This means we need to use `uv` (or pip) for documentation development.

:::{note} Future Documentation Environment
Once Jupyter Book 2 is available on conda-forge, we will create a dedicated pixi environment for documentation development. Until then, use the uv-based workflow below.
:::

### Installation with uv

1. **Install uv** (if not already available):
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   or if you're on Bruno

   ```bash
   ml uv
   ```

2. **Create a virtual environment for documentation:**
   ```bash
   uv venv -p 3.11
   source .venv/bin/activate
   ```

3. **Sync Dependencies**
   ```bash
   uv sync
   ```

### Building Documentation

1. **Build the documentation:**
   ```shell
   jupyter-book build .
   ```
2. **Interactive Builds:** (edit the documentation and see the changes as you write)
    ```shell
    jupyter-book start
    ```
3. **Compile a local PDF:**

    Since the documentation follows CommonMark, you are able to compile and export it via LaTeX or [Typst]. Refer to the [PDF Export documentation][jupyter-book-2-export-pdf] for more information.

    The configuration currently converts the Markdown into `Typst` which gets compiled to a PDF. You can build this PDF locally with:

    ```shell
    jupyter book build --pdf
    ```

### Development Workflow

1. **Make documentation changes** in the `docs/` directory using MyST Markdown
2. **Rebuild documentation** to see changes: `jupyter-book build .`
3. **Preview in browser** to verify formatting and content
4. **Submit pull request** with your documentation improvements

### Contributing Documentation

- Use MyST Markdown syntax for all documentation files
- Follow the existing structure and style conventions
- Test that all internal links work correctly
- Ensure code examples are accurate and tested

## Contributing Guidelines

When contributing to the biautils environment:

1. **Create an issue** first to discuss major changes
2. **Follow the existing code style** and conventions
3. **Test thoroughly** on Bruno before submitting
4. **Write clear commit messages** describing your changes
5. **Update documentation** if you add new features or change workflows

For questions or support, please [create an issue][cmbiautils-env-issues] on GitHub.

<!-- LINKS -->
[jupyter-book-2]: https://next.jupyterbook.org/
[cmbiautils-env-issues]: https://github.com/czbiohub-sf/compmicro-biautils-env/issues
[typst-link]: https://typst.app/
[jupyter-book-2-export-pdf]: https://next.jupyterbook.org/start/export-pdfs/
