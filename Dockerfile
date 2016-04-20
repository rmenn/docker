FROM alpine:edge

#PHP requirements
RUN apk update \
    && apk add ca-certificates curl \
    php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql \
    php-pcntl \
    php-sqlite3 \
    php-pdo_sqlite \
    php-posix \
    php-zip \
    php-gd php-iconv php-mcrypt \
    php-curl php-ctype \
    php-dom php-xmlreader && apk add -u musl && rm -rf /var/cache/apk/*

#AWS CLI
RUN apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
