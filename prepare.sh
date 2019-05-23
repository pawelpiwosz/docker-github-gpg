#! /bin/bash


# Set gpg binary

gpg_bin=$(which gpg2)
if [[ $? == 0 ]]; then
  echo "gpg2 installed"
else
  gpg_bin=$(which gpg)
  if [[ $? == 0 ]]; then
    echo "gpg installed"
  else
    echo "No gpg on this machine!"
    exit 1
  fi
fi

# Read input

read -p 'Provide gpg key name: ' gpgkeyname

echo "Checking gpg key"
result=$(gpg2 --list-secret-keys $gpgkeyname)
if [[ $? != 0 ]]; then
  echo "Key not found."
  exit 1
fi

read -p 'Provide your username for GitHub: ' git_user
read -p 'Provide your email address for GitHub: ' git_email
if [[ -z $git_user ]] || [[ -z $git_email ]]; then
  echo "All fields are required!"
  exit 1
fi

read -p 'Provide your username for Docker container: ' container_user
read -s -p 'Provide your password for Docker container: ' container_pass
if [[ -z $container_user ]] || [[ -z $container_pass ]]; then
  echo "All fields are required!"
  exit 1
fi

# Extract gpg key to files.

echo "Extracting private key"
$gpg_bin --export-secret-keys $1 > privkey.asc
if [[ $? != 0 ]]; then
  echo "Extract for private key failed!"
  exit 1
fi
echo "Extracting public key"
$gpg_bin --export $1 > pubkey.asc
if [[ $? != 0 ]]; then
  echo "Extract for public key failed!"
  exit 1
fi

# Extracting signing key.

echo "Extracting signing key"
sig_key=$($gpg_bin --list-secret-keys --keyid-format LONG|grep sec|sed 's/\// /'|awk {'print $3'})
if [[ $? != 0 ]]; then
  echo "Problem with signing key."
  exit 1
fi

# Copy ssh key

echo "Copying ssh key."
cp $HOME/.ssh/id_rsa* .
if [[ $? != 0 ]]; then
  echo "Files not copied."
  exit 1
fi

# Filling the .gitconfig file.

echo "Prepare .gitconfig"

cp .gitconfig_template .gitconfig
sed -i -e "s/github_name/$git_user/g" .gitconfig
sed -i -e "s/github_email/$git_email/g" .gitconfig
sed -i -e "s/github_signingkey/$sig_key/g" .gitconfig

# Filling the Dockerfile.

echo "Prepare Dockerfile"

cp Dockerfile_template Dockerfile
sed -i -e "s/docker_user/$container_user/g" Dockerfile
sed -i -e "s/docker_pass/$container_pass/g" Dockerfile

echo "Preparation stage complete."
exit 0
