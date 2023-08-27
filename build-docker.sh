#!/bin/bash
# Docker build script
set -e
cd "$(dirname "$0")"
if [ -z "$EXEC" ]; then
    EXEC=docker
fi
if [ -z "$IMAGE" ]; then
    IMAGE=docker.io/texlive/texlive:latest
fi
if [ -z "$WORKDIR" ]; then
    WORKDIR=/workdir
fi

$EXEC run -v "$PWD:$WORKDIR" "$IMAGE" ./build.sh