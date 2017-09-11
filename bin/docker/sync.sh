#!/bin/sh

rsync -rv --exclude-from=${BIN_DIR}/exclude-plugin-files.txt ${PLUGIN_PATH} ${REMOTE_PLUGIN_PATH}