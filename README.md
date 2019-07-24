## Docker image for signing github commits everywhere!

### Synopsis

It is nice to haver signed commits. This image allows it. Just build the image with
your credentials, and run with your project(s) directory mounted.

### Build

For building the image, you need a few things - sensitive data, like gpg and ssh keys, etc.
This repo contains bash scripts for prepare config, build the image and remove temporary data
from disk.

At the beginning, run

```
$ ./prepare.sh
```

Answer for all questions. Next, execute

```
$ ./build.sh
```

This script will build the Docker image. At this moment you can copy your image to private
repository. At the end of the process, run

```
./cleanbuild.sh
```

in order to remove temporarly created files and image itself from your disk.

### Usage

#### Linux

In order to run the container, use:

```
docker run -ti -d \
--name github \
-h github \
--restart always \
-v /home/user-name/your-repo-dir/:/repo github-gpg \
-v /etc/localtime:/etc/localtime:ro
```
#### Windows

```
docker run -ti -d \
--name github \
-h github \
--restart always \
-u user \
-v //c/Users/user/GIT:/home/user/GIT:rw github-gpg
```

In order to synchronize time with host, localtime file is mounted.

### Kudos

Special thanks to [Marco](https://github.com/mmatoscom/) as provider of the
idea. And I shamelessly used his Dockerfile :)
