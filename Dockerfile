FROM python:3.6-alpine

EXPOSE 8000

RUN mkdir /documents
RUN mkdir /site
WORKDIR /documents

COPY requirements.txt .
RUN \
  pip install -r requirements.txt && \
  pip install mkdocs-material && \
  rm requirements.txt
RUN mkdocs serve --help

ENTRYPOINT ["mkdocs", "-", "material"]
