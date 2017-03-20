docker run -ti --rm -v $(pwd):/$(pwd) -w $(pwd) -e DOCKER_HOST=10.173.162.72:2376  docker/compose:1.9.0 up -d
