FROM alpine:3.3

ENV REDASH_STATIC_ASSETS_PATH="../rd_ui/dist/"
ENV REDASH_DIR="/opt/redash/current"
ENV REDASH_HOME="/home/redash"


    #Redash requirements
RUN apk update && \
    apk --no-cache add bash \
    alpine-sdk \
    coreutils \
    py-pip \
    python-dev \
    curl \
    pwgen \
    libffi-dev \
    sudo \
    git \
    wget \
    tar \
    # Postgres-client
    postgresql-dev \
    # Additional packages required for data sources:
    mysql-client \
    freetds-dev \
    openssl-dev \
    cyrus-sasl-dev \
    # nodejs
    nodejs &&\
    rm -rf /var/cache/apk/*

RUN adduser -s /bin/bash -D -h ${REDASH_HOME} -S redash && \
    echo "redash ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p ${REDASH_DIR} && \
    REDASH_URL="https://github.com/getredash/redash/releases/download" && \
    REDASH_VERSION="0.11.1.b2095" && \
    REDASH_RELEASE="v${REDASH_VERSION}/redash.${REDASH_VERSION}.tar.gz" && \
    wget ${REDASH_URL}/${REDASH_RELEASE} && \
    tar -zxvf redash.${REDASH_VERSION}.tar.gz --directory ${REDASH_DIR} && \
    chown -R redash ${REDASH_DIR}

    # Setting working directory
WORKDIR ${REDASH_DIR}

    # Pip requirements for all data source types
RUN pip install --upgrade pip && \
    pip install -U setuptools==23.1.0 && \
    pip install supervisor==3.1.2 && \
    # Install project specific dependencies
    pip install -r requirements.txt && \
    pip install google-api-python-client==1.2 && \
    gspread==0.2.5 && \
    oauth2client==1.2 && \
    pyOpenSSL==0.14 && \
    botocore==1.4.4 && \
    pip install sasl>=0.1.3


RUN sudo -u redash -H make deps && \
    rm -rf node_modules rd_ui/node_modules ${REDASH_HOME}/.npm ${REDASH_HOME}/.cache && \
    apk --purge -v del nodejs && \
    rm -rf /var/cache/apk/*

    # Setup supervisord
RUN mkdir -p /opt/redash/supervisord && \
    mkdir -p /opt/redash/logs && \
    cp ${REDASH_DIR}/setup/docker/supervisord/supervisord.conf /opt/redash/supervisord/supervisord.conf && \
    chown -R redash /opt/redash

    # Expose ports
EXPOSE 5000
EXPOSE 9001

    # Startup script
CMD ["supervisord", "-c", "/opt/redash/supervisord/supervisord.conf"]
