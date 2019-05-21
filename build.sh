#! /bin/bash

echo "Build Docker image."

docker build -t github-gpg .

docker images |grep "^github-gpg "

echo "Build finished."
