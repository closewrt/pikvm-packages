#!/bin/bash -ex

tag=$(echo ${PWD} | tr / - | cut -b2- | tr A-Z a-z)
groups=$(id -G | xargs -n1 echo -n " --group-add ")
params="-v ${PWD}:${PWD} --rm -w ${PWD} -u"$(id -u):$(id -g)" $groups -v$HOME/.gitconfig:$HOME/.gitconfig:ro -v$HOME/.ssh:$HOME/.ssh:ro -v/etc/hosts:/etc/hosts:ro ${tag}"

docker build --build-arg USERNAME=$USER --tag=${tag} docker -f docker/Dockerfile

docker run -it $params $@
