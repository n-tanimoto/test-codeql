import os
import sys

from create_database_utils import *
from diagnostics_test_utils import *

os.environ['LGTM_INDEX_IMPORT_PATH'] = "glidetest"
run_codeql_database_create([], lang="go", source="work")

check_diagnostics()
