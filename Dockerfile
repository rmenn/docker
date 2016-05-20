FROM alpine:edge

#PHP requirements
RUN apk update \
    && apk add ca-certificates curl \
    unzip \
    wget && rm -rf /var/cache/apk/*

ENV VERSION 0.6.16
ENV PATH $PATH:$HOME/terraform

RUN mkdir -p $HOME/terraform && \
    cd $HOME/terraform && \
    wget https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip && \
    unzip terraform_${VERSION}_linux_amd64.zip && \
    rm terraform_${VERSION}_linux_amd64.zip
