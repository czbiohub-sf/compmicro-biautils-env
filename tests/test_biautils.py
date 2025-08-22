from importlib.metadata import PackageNotFoundError, version

from biautils import print_environment_info


def env_version():
    """Print biautils version information to stdout."""
    try:
        package_version = version("biautils")
        print(f"biautils\t{package_version}")
    except PackageNotFoundError:
        print("biautils\tunknown")


def test_biautils_version_functionality(capsys):
    """Test that we can get biautils version information correctly."""
    # Test the print function
    env_version()
    captured = capsys.readouterr()

    # Verify output format and content
    assert len(captured.out) > 0
    output_lines = captured.out.strip().split("\n")
    assert len(output_lines) == 1

    package_version_line = output_lines[0]
    parts = package_version_line.split("\t")
    assert len(parts) == 2
    assert parts[0] == "biautils"

    # Verify version matches importlib.metadata.version
    expected_version = version("biautils")
    assert parts[1] == expected_version


def test_print_environment_info(capsys):
    """Test that print_environment_info produces expected output."""
    # Call the function
    print_environment_info()

    # Capture the output
    captured = capsys.readouterr()

    # Verify that output was produced
    assert len(captured.out) > 0

    # Check for key elements in the output
    output = captured.out

    # Should contain biautils version info
    assert "biautils" in output.lower()

    # Should contain Python version info
    assert "python" in output.lower()

    # Should contain dependency categories
    assert "napari" in output.lower()
    assert "scientific computing" in output.lower() or "scipy" in output.lower()

    # Should contain summary information
    assert "summary" in output.lower() or "packages installed" in output.lower()

    # Should contain dependency tree structure
    assert "dependencies" in output.lower()

    # Verify the output has multiple lines (header, tree, summary)
    lines = captured.out.strip().split("\n")
    assert len(lines) > 5  # Should have header, tree structure, and summary
