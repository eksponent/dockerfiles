FROM alpine:latest

RUN apk add --update python
RUN apk add --update py-pip
RUN pip install --upgrade pip
RUN apk --update add ca-certificates python
RUN pip install python-dateutil

RUN pip install s3cmd

RUN mkdir /opt
WORKDIR /opt

ENTRYPOINT ["s3cmd"]