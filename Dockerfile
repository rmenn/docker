FROM alpine:edge

ENV PACKER_VERSION 0.10.0

# Python, Pip
RUN apk --update add python py-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi

# AWS-Cli
RUN apk -Uuv add groff                && \
    pip install awscli

# Ansible
RUN pip install ansible==1.9.4

# Packer
RUN cd /tmp/packer                    &&\
    apk add --update bash curl openssh-client git unzip &&\
    curl -O -sS -L https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip &&\
    unzip packer_${PACKER_VERSION}_linux_amd64.zip &&\
    apk del unzip                     &&\
    mv packer* /usr/local/bin

# Clean up
RUN apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    rm -rf /tmp/packer
