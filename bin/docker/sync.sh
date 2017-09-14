#!/bin/sh

rsync -r --exclude-from=${BIN_DIR}/exclude-plugin-files.txt ${PLUGIN_PATH} ${REMOTE_PLUGIN_PATH}