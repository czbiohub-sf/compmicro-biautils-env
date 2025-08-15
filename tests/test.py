from io import StringIO
from unittest import TestCase
from unittest.mock import patch

from . import _env_version_tuple, env_version


class TestEnvVersion(TestCase):
    @patch("sys.stdout", new_callable=StringIO)
    def test_env_version(self, mock_stdout):
        # Confirm non-empty stdout when calling env_version
        # Excpected value is "${package_name}\t${version}"
        env_version()
        assert len(mock_stdout.getvalue()) > 0

    def test_env_version_tuple(self):
        # Confirm non-empty strings for package and version
        (package, version) = _env_version_tuple()
        assert len(package) > 0
        assert len(version) > 0
