FROM node:7

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-17.03.0-ce.tgz \
    && tar -xz -C /tmp -f /tmp/docker.tgz \
    && mv /tmp/docker/docker* /usr/bin/

RUN pip3 install awscli

ENV GODIST go1.8.linux-amd64.tar.gz
RUN mkdir -p downloads \
    && curl -o downloads/$GODIST https://storage.googleapis.com/golang/$GODIST
    && rm -rf /usr/local/go
    && tar -C /usr/local -xzf downloads/$GODIST