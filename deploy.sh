#!/bin/sh

docker run -it --rm -v $(pwd):/documents mkdocs gh-deploy -b master
