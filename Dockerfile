FROM alpine:3.4

ENV PACKER_VERSION 0.10.1

# Install Ansible
RUN apk --update add python py-pip openssl ca-certificates git && \
    apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi        && \
    pip install git+https://github.com/fugue/emulambda.git && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*

