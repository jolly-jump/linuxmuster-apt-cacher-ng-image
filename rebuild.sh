#!/bin/bash

git status
docker pull debian:stable-slim
docker inspect debian:stable-slim | grep RepoTags -A 3
git_log=$(git log --oneline | head -1 | cut -d " " -f 1)
echo "now build with: docker build -t hgkvplan/apt-cacher-ng:stable-slim-$git_log ."
