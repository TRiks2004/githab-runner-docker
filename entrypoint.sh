#!/bin/bash

echo "Starting runner..."

# Set the necessary permissions for the Docker socket if required
chmod 660 /var/run/docker.sock

# Switch to the GitHub Actions runner user
su github

# If the runner configuration file doesn't exist, set it up
if [ ! -f .runner ]; then
    ./config.sh --url "$GITHUB_URL" --token "$GITHUB_TOKEN" --name "$RUNNER_NAME" \
            --labels "$RUNNER_LABELS" --work "$WORK_DIR" --runnergroup "$RUNNER_GROUP" --unattended
fi

# Start the runner
./run.sh

# Execute the main container command
exec "$@"