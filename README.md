## Docker image for signing github commits everywhere!

### Synopsis

It is nice to haver signed commits. This image allows it. Just build the image with
your credentials, and run with your project(s) directory mounted.

### Usage

In order to build the container, use:

```
docker build -t github-gpg .
```


In order to run the container, use:

```
docker run -ti -d \
--name github \
-h github \
--restart always \
-v /home/user-name/your-repo-dir/:/repo image_name
```

```
