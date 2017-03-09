FROM node:7

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli