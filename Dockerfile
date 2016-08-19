FROM alpine:3.4

#PHP requirements
RUN apk update \
    && apk add ca-certificates curl \
    php5-json php5-zlib php5-xml php5-pdo php5-phar php5-openssl \
    php5-pdo_mysql \
    php5-pcntl \
    php5-sqlite3 \
    php5-pdo_sqlite \
    php5-posix \
    php5-zip \
    php5-gd php5-iconv php5-mcrypt \
    php5-curl php5-ctype \
    imagemagick \
    php5-dom php5-xmlreader \
    xvfb \
    git \
    java-common && apk add --no-cache openjdk7-jre=7.91.2.6.3-r2 && apk add -u musl && rm -rf /var/cache/apk/* && wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.1.jar

#AWS CLI
RUN apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
