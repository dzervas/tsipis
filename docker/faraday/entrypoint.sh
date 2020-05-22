#!/bin/sh
mkdir -p ~/.faraday/config

if [ ! -e ~/.faraday/config/server.ini ]; then
  envsubst < server.docker.ini > ~/.faraday/config/server.ini
fi

exec "$@"
