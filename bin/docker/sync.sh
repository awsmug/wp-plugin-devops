#!/bin/sh

rsync -r --exclude-from=${VENDOR_BIN_PATH}/exclude-plugin-files.txt ${PLUGIN_PATH} ${REMOTE_PLUGIN_PATH}