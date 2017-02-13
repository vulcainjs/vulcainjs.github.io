docker build -t mkdocs .
docker run -ti --rm -v %~dp0:/docs -v %~dp0/site:/site mkdocs build
