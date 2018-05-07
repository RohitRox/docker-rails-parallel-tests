#!/bin/bash -e

echo "Removing exited containers..."
docker ps -a -qf status=exited | xargs -I {} docker rm -v {}

echo "Removing dangling images..."
docker images -qf "dangling=true" | xargs -I {} docker rmi {}

volume_count=$(docker volume ls -q -f dangling=true | wc -l)

if [ $volume_count -gt 5 ]; then
  echo "Cleaning up dangling volumes ..."
  docker volume rm `docker volume ls -q -f dangling=true`
fi

echo "Possible Docker trash is cleansed."
