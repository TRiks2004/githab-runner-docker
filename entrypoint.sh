#!/bin/bash

echo "Starting runner..."

su root
sudo chmod 660 /var/run/docker.sock
su github

if [ ! -f .runner ]; then
    ./config.sh --url "$GITHUB_URL" --token "$GITHUB_TOKEN" --name "$RUNNER_NAME" \
            --labels "$RUNNER_LABELS" --work "$WORK_DIR" --runnergroup "$RUNNER_GROUP" --unattended
fi

./run.sh

exec "$@"  # Запускаем основную команду контейнера