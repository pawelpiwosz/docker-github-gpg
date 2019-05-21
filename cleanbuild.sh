#! /bin/bash

# Remove sensitive files

files=(
  ".gitconfig"
  "Dockerfile"
  "privkey.asc"
  "pubkey.asc"
)

for file in ${files[*]}
do
  if [[ -f ${file} ]]; then
    rm $file
    if [[ -f $file ]]; then
      echo "Cannot remove ${file}!"
      exit 1
    fi
  else
    continue
  fi
done

# Remove Docker images

docker images -a | grep "^github " |awk '{print $3}' | xargs docker rmi
docker images purge

echo "Sensitive files removed."
