#!/bin/sh

docker run -it --rm --name documents -v $(pwd):/documents mkdocs gh-deploy
