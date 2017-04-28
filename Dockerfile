FROM alpine:3.4

RUN apk --update add python py-pip openssl ca-certificates git && \
    apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi        && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*

# Custom C Headers for Alpine
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Install Emulambda
RUN pip install git+https://github.com/fugue/emulambda.git
