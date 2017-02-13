#!/bin/sh

docker run -it --rm -v $(pwd):/docs mkdocs gh-deploy -b master
