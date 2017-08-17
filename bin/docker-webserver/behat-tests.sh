#!/usr/bin/env bash

# Run behat commands in a running behat container
# Have to use `docker exec`, since `docker-compose run` won't work on Windows
# Make sure this works directly or via Docksal Fin
if (type fin >/dev/null 2>&1); then fin_cmd='fin'; fi
$fin_cmd docker exec $($fin_cmd docker-compose -f "${BIN_PATH}/docker-compose.yml" ps -q behat) behat --colors --format=pretty --out=std --out=log/behat "$@"

# echo "To view HTML report visit: http://<your-docker-host-ip>:8081/html_report"