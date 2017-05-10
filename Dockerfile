FROM nodesource/trusty

# Install Jinja2
RUN apt-get update && \
    apt-get -y install python-setuptools python-dev && \
    easy_install Jinja2 && \
    npm install js-yaml@^3.8.4 jsonlint@^1.6.2 &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*
