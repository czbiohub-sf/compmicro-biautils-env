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

2. **Load pixi and install the development environment:**
   ```bash
   module load pixi
   pixi install -e dev
   ```

3. **Make your changes** to `pixi.toml` or other configuration files

4. **Test your changes:**
   ```bash
   pixi install -e dev  # Re-install after changes
   pixi shell -e dev    # Test the development environment
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

### Running Tests

The project includes testing capabilities in both the development and CI environments:

::::{tab-set}
:::{tab-item} Development Environment
:sync: env-dev

Use the `dev` environment for comprehensive testing with all dependencies:

```{code} shell
:label: run-tests-dev
:caption: Run the test suite in development environment
pixi run -e dev tests
```

```{code} shell
:label: run-tests-dev-verbose
:caption: Run tests with verbose output (development)
pixi run -e dev pytest tests/ -v
```
:::

:::{tab-item} CI Environment  
:sync: env-ci

Use the `ci` environment for lightweight testing without heavy ML dependencies:

```{code} shell
:label: run-tests-ci
:caption: Run the test suite in CI environment
pixi run -e ci tests
```

```{code} shell
:label: run-tests-ci-verbose
:caption: Run tests with verbose output (CI)
pixi run -e ci pytest tests/ -v
```
:::
::::

To run specific test files or test functions:
```{code} shell
:label: run-specific-tests
:caption: Run specific tests
pixi run -e dev pytest tests/test_specific.py::test_function -v
```

The `dev` environment includes all packages for comprehensive testing, while the `ci` environment provides faster, lightweight testing perfect for automated workflows.

## Building Documentation Locally

### Using Pixi Environments

The documentation is built using [Jupyter Book 2][jupyter-book-2], which is now available through pixi in both the development and CI environments:

::::{tab-set}
:::{tab-item} Development Environment
:sync: env-dev

Use the `dev` environment for comprehensive documentation building with all dependencies:

```{code} shell
:label: docs-build-dev
:caption: Build documentation in development environment
pixi run -e dev docs-build
```

```{code} shell
:label: docs-start-dev
:caption: Start interactive documentation server (development)
pixi run -e dev docs-start
```

```{code} shell
:label: docs-pdf-dev
:caption: Build PDF documentation (development)
pixi run -e dev docs-pdf
```
:::

:::{tab-item} CI Environment
:sync: env-ci

Use the `ci` environment for lightweight documentation building in automated workflows:

```{code} shell
:label: docs-build-ci
:caption: Build documentation in CI environment
pixi run -e ci docs-build
```

```{code} shell
:label: docs-start-ci
:caption: Start interactive documentation server (CI)
pixi run -e ci docs-start
```

```{code} shell
:label: docs-pdf-ci
:caption: Build PDF documentation (CI)
pixi run -e ci docs-pdf
```
:::
::::

### Manual Jupyter Book Commands

You can also run jupyter-book directly in either environment:

```{code} shell
:label: docs-manual-build
:caption: Manual documentation build
pixi run -e dev jupyter-book build .
pixi run -e dev jupyter-book start .    # Interactive mode
```

### PDF Documentation

Since the documentation follows CommonMark, you can compile and export it via LaTeX or [Typst][typst-link]. Refer to the [PDF Export documentation][jupyter-book-2-export-pdf] for more information.

The configuration currently converts the Markdown into `Typst` which gets compiled to a PDF using the `docs-pdf` task.

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
