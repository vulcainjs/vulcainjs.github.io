#!/bin/sh

docker build -t documents .
docker rm -f documents 
docker run -d -p 8000:8000 --name documents -v `pwd`:/docs squidfunk/mkdocs-material
docker logs -f documents