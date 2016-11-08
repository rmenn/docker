FROM alpine:edge

#php5 requirements
RUN apk update \
    && apk add ca-certificates curl \
    php5-json php5-zlib php5-xml php5-pdo php5-phar php5-openssl \
    php5-pdo_mysql \
    php5-pcntl \
    php5-sqlite3 \
    php5-pdo_sqlite \
    php5-posix \
    php5-zip \
    php5-soap \
    php5-gd php5-iconv php5-mcrypt \
    php5-curl php5-ctype \
    coreutils \
    bash \
    git \
    imagemagick \
    zip \
    php5-dom php5-xmlreader && apk add -u musl && rm -rf /var/cache/apk/*

#AWS CLI
RUN apk -Uuv add groff less python py2-pip && \
    pip install --upgrade pip && \
    pip install awscli && \
    apk --purge -v del py2-pip && \
    rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php5 && mv composer.phar /usr/local/bin/composer
