#!/bin/sh

docker rm -f documents 
docker run -d -p 8000:8000 --name documents -v $(pwd):/documents mkdocs serve
docker logs -f documents