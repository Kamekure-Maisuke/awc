FROM alpine:latest
MAINTAINER t_o_d

RUN apk update --no-cache && \
	apk add --no-cache curl gawk libxml2-utils && \
	rm -rf /var/cache/apk/*

WORKDIR work

COPY . .
