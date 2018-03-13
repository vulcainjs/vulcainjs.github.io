FROM python:3.6-alpine

EXPOSE 8000

WORKDIR /docs

COPY requirements.txt .

RUN apk update && apk add git && \
  pip install -r requirements.txt && \
  pip install mkdocs-material && \
  rm requirements.txt

ENTRYPOINT ["mkdocs"]
CMD ["serve"]
