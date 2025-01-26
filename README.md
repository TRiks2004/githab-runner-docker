## Docker

```bash
docker run -d \
  --name github-runner \
  --restart unless-stopped \
  --env GITHUB_URL=https://github.com/danilkis/Disona \
  --env GITHUB_TOKEN=AGKYN3MCNMFDHGUPBVBFPETHSWQQQ \
  --env RUNNER_NAME=default \
  --env RUNNER_LABELS=ubuntu,build \
  --env WORK_DIR=/github-runner/_work \
  --env RUNNER_GROUP=default \
  --network host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  ghcr.io/triks2004/githab-runner-docker:<version>
```

## Docker Compose

```yaml

services:
  githab-runner-docker:
    image: ghcr.io/triks2004/githab-runner-docker:<version>
    container_name: github-runner
    restart: unless-stopped
    environment:
      - GITHUB_URL=https://github.com/danilkis/Disona
      - GITHUB_TOKEN=AGKYN3MCNMFDHGUPBVBFPETHSWQQQ
      - RUNNER_NAME=default
      - RUNNER_LABELS=ubuntu,build
      - WORK_DIR=/github-runner/_work
      - RUNNER_GROUP=default
    network_mode: "host"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

```