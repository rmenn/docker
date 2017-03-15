FROM frolvlad/alpine-glibc

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
    php7-fpm \
    php7-gd php7-iconv php7-mcrypt \
    php7-curl php7-ctype \
    coreutils \
    bash \
    git \
    imagemagick \
    zip \
    nginx \
    mysql-client \
    musl \
    php7-dom php7-xmlreader && \

    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php7/php.ini && \
    apk add -u musl && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    rm -rf /var/cache/apk/* && \
    curl -sS https://getcomposer.org/installer | php7 && mv composer.phar /usr/local/bin/composer && \
    mkdir /app/

RUN apk add --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community yarn && \
    yarn global add gulp

COPY files/nginx.conf /etc/nginx/

COPY files/php-fpm.conf /etc/php7/

COPY files/www.conf /etc/php7/php-fpm.d
