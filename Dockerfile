FROM alpine:3.5

#php7 requirements
RUN apk update \
    && apk add ca-certificates curl \
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
    php7-apache2 \
    php7-gd php7-iconv php7-mcrypt \
    php7-curl php7-ctype \
    coreutils \
    bash \
    git \
    imagemagick \
    zip \
    apache2 \
    mysql-client \
    musl \
    php7-dom php7-xmlreader && \
    apk add -u musl && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    rm -rf /var/cache/apk/* && \
    curl -sS https://getcomposer.org/installer | php7 && mv composer.phar /usr/local/bin/composer && \
    mkdir /app/
