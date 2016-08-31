#!/bin/bash

if [ -x "./server" ]; then
  rm ./server
fi

echo "building source file"
GOPATH=$(pwd) CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .
if [ $? -ne 0 ]; then
  echo "build failed."
  exit 1
fi
echo "done."

echo "setting up docker image"
docker build -t go-dockerweb -f Dockerfile.scratch .
if [ $? -ne 0 ]; then
  echo "build failed."
  exit 1
fi
echo "done."

echo "you can now start the container by running:"
echo "  docker run -it -p 127.0.0.1:8080:8080 go-dockerweb"
