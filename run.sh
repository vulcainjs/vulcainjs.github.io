#!/bin/sh

docker build -t mkdocs .
docker rm -f documents 
docker run -d -p 8000:8000 --name documents -v `pwd`:/docs  mkdocs
docker logs -f documents