#!/bin/bash -e

specs="$@"
container_name="${specs//./_}"
container_name="${container_name// /_}"
container_name="${container_name//\//_}"
container_name="${container_name//\*/_}"
container_name="${container_name//_/}"

echo "Running in container $container_name: docker-compose run --rm --name bundle exec rspec --colour --tty $@"

docker-compose run --rm --name $container_name app ./docker/spec-runner.sh "$@"
