#!/bin/bash

echo "Starting runner..."

echo "./config.sh --url \"$GITHUB_URL\" --token \"$GITHUB_TOKEN\" --name \"$RUNNER_NAME\" \
    --labels \"$RUNNER_LABELS\" --work \"$WORK_DIR\" --runnergroup \"$RUNNER_GROUP\" --unattended"

./config.sh --url "$GITHUB_URL" --token "$GITHUB_TOKEN" --name "$RUNNER_NAME" \
            --labels "$RUNNER_LABELS" --work "$WORK_DIR" --runnergroup "$RUNNER_GROUP" --unattended

./run.sh