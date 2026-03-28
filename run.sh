#!/bin/bash

set -e

docker compose down
docker compose up -d --build
docker system prune -a -f --volumes
