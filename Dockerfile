# Install alpine + java8 with JCE unlimited jurisdiction policy
FROM anapsix/alpine-java:8_jdk_unlimited

MAINTAINER Miroojin Bakshi <miroojin.bakshi@razorpay.com>

RUN apk update \
	&& apk add curl \
	git \
	nodejs \
	wget \
	&& apk add -u musl \
	&& rm -rf /var/cache/apk/* 

# Install gulp
RUN /usr/bin/npm install -g gulp

# Set up environment variables
ENV HOME="/home/user"
ENV ANDROID_HOME="${HOME}/android-sdk-linux"

ENV PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}" \
	SDK_URL="https://dl.google.com/android/repository/tools_r25.2.3-linux.zip"

WORKDIR $HOME

# Download Android SDK and update to latest version
RUN mkdir $ANDROID_HOME && \
	curl -o sdk.zip $SDK_URL && \
	unzip sdk.zip -d $ANDROID_HOME && \
	rm sdk.zip && \
	mkdir $ANDROID_HOME/licenses && \
	echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license

# Update SDK 
RUN $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" && \
	$ANDROID_HOME/tools/bin/sdkmanager "build-tools;25.0.2" && \
	$ANDROID_HOME/tools/bin/sdkmanager "platforms;android-25" "platforms;android-24" && \
	$ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository"

# AWS CLI
RUN apk -Uuv add groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

# Force gradle to use plain console output
ENV TERM dumb