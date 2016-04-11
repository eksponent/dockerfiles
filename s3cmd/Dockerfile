FROM alpine:latest

RUN apk add --update python
RUN apk add --update py-pip
RUN pip install python-dateutil

ADD files/s3cmd-1.6.1.tar.gz /usr/local/bin/

RUN mkdir /opt
WORKDIR /opt

ENTRYPOINT ["s3cmd"]