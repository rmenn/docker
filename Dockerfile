FROM alpine:3.5

#php7 requirements
RUN apk add --update \
    ca-certificates curl \
    php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
    php7-pdo_mysql \
    php7-pcntl \
    php7-mbstring \
    php7-sqlite3 \
    php7-pdo_sqlite \
    php7-posix \
    php7-zip \
    php7-session \
    php7-soap \
    php7-gd php7-iconv php7-mcrypt \
    php7-curl php7-ctype php7-bcmath php7-gmp \
    coreutils \
    gmp \
    bash \
    git \
    imagemagick \
    zip \
    python \
    python-dev \
    py-pip \
    php7-dom php7-xmlreader && \
    apk add -u musl && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    rm -rf /var/cache/apk/*

#AWS CLI
RUN apk -Uuv add groff less python py2-pip && \
    pip install awscli request && \
    apk --purge -v del py2-pip && \
    rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php7 && mv composer.phar /usr/local/bin/composer
