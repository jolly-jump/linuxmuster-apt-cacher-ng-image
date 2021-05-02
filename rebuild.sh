#!/bin/bash

buildoptions=$@
echo "Build options: $buildoptions"
git status
VERSION="stable-slim"
docker pull debian:${VERSION}
docker inspect debian:${VERSION} | grep RepoTags -A 3
git commit -a -m"linuxmuster-apt-cacher-ng: debian:${VERSION}" 

git_log=$(git log --oneline | head -1 | cut -d " " -f 1)
docker tag humbihupf/linuxmuster-apt-cacher-ng:latest humbihupf/linuxmuster-apt-cacher-ng:previous
echo "Press enter to build with: docker build $buildoptions -t humbihupf/linuxmuster-apt-cacher-ng:${VERSION}-$git_log ."
read
docker build $buildoptions -t humbihupf/linuxmuster-apt-cacher-ng:$VERSION-$git_log .
[ $? -ne 0 ] && echo error && exit 1
docker tag humbihupf/linuxmuster-apt-cacher-ng:$VERSION-$git_log humbihupf/linuxmuster-apt-cacher-ng:latest
[ $? -ne 0 ] && echo error && exit 1

echo "docker push humbihupf/linuxmuster-apt-cacher-ng:latest"
echo "docker push humbihupf/linuxmuster-apt-cacher-ng:$VERSION-$git_log"
[ $? -ne 0 ] && echo error && exit 1
docker push humbihupf/linuxmuster-apt-cacher-ng:latest
[ $? -ne 0 ] && echo error && exit 1
docker push humbihupf/linuxmuster-apt-cacher-ng:$VERSION-$git_log
[ $? -ne 0 ] && echo error && exit 1

echo "no error"
exit 0

