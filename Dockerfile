FROM ubuntu:22.04

ENV GITHUB_URL="https://github.com/danilkis/Disona"
ENV GITHUB_TOKEN="AGKYN3LSBHLRFSZQ2NQ3HLLHSV7Y6"
ENV RUNNER_NAME="default"
ENV RUNNER_LABELS="ubuntu,build"
ENV WORK_DIR="/github-runner/_work"
ENV RUNNER_GROUP="default"

WORKDIR /github-runner

# Обновляем пакеты и устанавливаем необходимые зависимости
RUN apt-get update && \
    apt-get install -y \
    curl \
    bash \
    tar \
    git \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

ENV RUNNER_VERSION="2.321.0"

# Скачиваем последнюю версию пакета runner
RUN curl -o actions-runner-linux-x64-$RUNNER_VERSION.tar.gz -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz && \
    # Распаковываем архив
    tar xzf actions-runner-linux-x64-$RUNNER_VERSION.tar.gz && \
    # Удаляем архив после распаковки
    rm actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

RUN ./bin/installdependencies.sh

COPY entrypoint.sh /github-runner/entrypoint.sh
RUN chmod +x /github-runner/entrypoint.sh

# Создаем нового пользователя, чтобы запустить runner без root прав
RUN adduser --disabled-password --gecos "" github && \
    usermod -aG docker github && \
    chown -R github:github /github-runner

# Переключаемся на пользователя github
USER github

# Последний шаг: запуск runner
ENTRYPOINT ["/github-runner/entrypoint.sh"]