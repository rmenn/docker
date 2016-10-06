FROM ubuntu:14.04
MAINTAINER Joy Bhattacherjee <joy.bhattacherjee@gmail.com>
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && apt-get -y install software-properties-common \
    python-software-properties \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get -y install \
    ca-certificates \
    curl \
    xvfb \
    git \
    bash \
    lsof \
    nodejs \
    wget \
    java-common \
    firefox \
    php5.6 \
    php5.6-json \
    php5.6-xml \
    php5.6-pdo \
    php5.6-phar \
    php5.6-mysql \
    php5.6-sqlite \
    php5.6-posix \
    php5.6-zip \
    php5.6-iconv \
    php5.6-mcrypt \
    php5.6-curl \
    php5.6-ctype \
    php5.6-dom \
    php5.6-xmlreader \
    imagemagick \
    openjdk-7-jre-headless \
    musl \
    && rm -rf /var/lib/cache /var/lib/log /tmp/*\
    && wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.1.jar

#AWS CLI
RUN apt-get -y install groff less python python-pip && \
    pip install awscli && \
    apt-get -y purge python-pip wget \
    && apt-get -y autoremove \
    && rm -rf /var/lib/cache /var/lib/log /tmp/*

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
