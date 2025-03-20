#!/bin/sh

# Usage: ./wait-for.sh host:port -- command args
set -e

hostport="$1"
shift

host=$(echo "$hostport" | cut -d: -f1)
port=$(echo "$hostport" | cut -d: -f2)

echo "Waiting for $host:$port..."

while ! nc -z "$host" "$port"; do
  sleep 0.5
done

echo "$host:$port is available, executing command..."
exec "$@"
