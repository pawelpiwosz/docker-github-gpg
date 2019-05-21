#! /bin/bash

echo "Build Docker image."

docker build -t github .

docker images |grep "^github "

echo "Build finished."
