#!/usr/bin/env python3

import configparser
import sys
import os
from pathlib import Path

script_dir = Path(os.path.dirname(os.path.realpath(__file__)))
ugc_root = script_dir / 'ungoogled-chromium'
common_config = ugc_root / 'resources' / 'config_bundles' / 'common' / 'version.ini'

config = configparser.ConfigParser()
config.read(str(common_config))

version = config['version']
chromium_version = version['chromium_version']
release_revision = version['release_revision']

full_version = '_'.join((chromium_version, release_revision))

print(full_version)
