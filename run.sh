#!/bin/sh

docker rm -f documents 
docker run -d -p 8000:8000 --name documents -v $(pwd):/documents mkdocs
docker logs -f documents