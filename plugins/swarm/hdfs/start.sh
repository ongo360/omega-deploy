#docker run -ti --rm -v $(pwd):$(pwd) -e DOCKER_HOST=10.173.162.72:2375 -w $(pwd)  docker/compose:1.9.0 up -d
docker run -ti --rm -v $(pwd):$(pwd) -e DOCKER_HOST=10.173.162.72:8080 -w $(pwd)  docker/compose:1.9.0 up -d
