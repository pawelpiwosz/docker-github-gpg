## Docker image for signing github commits everywhere!

### Synopsis

It is nice to haver signed commits. This image allows it. Just build the image with
your credentials, and run with your project(s) directory mounted.

### Usage

In order to build the container, use:

```
docker build -t docker-gpg .
```


In order to run the container, use:

```
docker run -ti -d \ 
--name github \ 
-h github \ 
--restart always \ 
-v /home/user-name/your-repo-dir/:/repo image_name
```

### This repo

This repo contains Ansible playbook to build image with all credentials.

In order to do it, run:

```
some command
```

```
ansible localhost -a "hostname"
```
