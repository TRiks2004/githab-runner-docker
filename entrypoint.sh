#!/bin/bash

echo "Starting runner..."

echo "chmod 660 /var/run/docker.sock"
# Set the necessary permissions for the Docker socket if required
chmod 660 /var/run/docker.sock

ls

# If the runner configuration file doesn't exist, set it up
if [ ! -f .runner ]; then
    su github -c '/github-runner/config.sh --url "$GITHUB_URL" --token "$GITHUB_TOKEN" --name "$RUNNER_NAME" \
        --labels "$RUNNER_LABELS" --work "$WORK_DIR" --runnergroup "$RUNNER_GROUP" --unattended'
fi

# Start the runner
su - github -c '/github-runner/run.sh'

# Execute the main container command
exec "$@"