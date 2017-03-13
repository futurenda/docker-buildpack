FROM node:7

# Python 3, unzip
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
        unzip \
	&& rm -rf /var/lib/apt/lists/*

# Docker 17.03
RUN curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-17.03.0-ce.tgz \
    && tar -xz -C /tmp -f /tmp/docker.tgz \
    && mv /tmp/docker/docker* /usr/bin/

# docker-compose 1.11.2
RUN curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# awscli
RUN pip3 install awscli

# Go 1.8
ENV GODIST go1.8.linux-amd64.tar.gz
RUN mkdir -p /tmp/downloads \
    && curl -o /tmp/downloads/$GODIST https://storage.googleapis.com/golang/$GODIST \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf /tmp/downloads/$GODIST

# protoc 3.1
RUN mkdir -p /tmp/downloads/protoc \
    && cd /tmp/downloads/protoc \
    && wget https://github.com/google/protobuf/releases/download/v3.1.0/protoc-3.1.0-linux-x86_64.zip \
    && unzip protoc-3.1.0-linux-x86_64.zip \
    && cp bin/protoc /usr/bin \
    && rm -rf /tmp/downloads/protoc

# protoc-gen-go
RUN go get -u github.com/golang/protobuf/{proto,protoc-gen-go}

# golint
RUN go get -u github.com/golang/lint/golint