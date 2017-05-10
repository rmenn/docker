FROM openjdk:8

MAINTAINER Miroojin Bakshi <miroojin.bakshi@razorpay.com>

# Install Git and dependencies
RUN dpkg --add-architecture i386 \
 	&& curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh \
 	&& chmod a+x nodesource_setup.sh && ./nodesource_setup.sh \
 	&& apt-get update \
 	&& apt-get install -y file git expect curl zip libncurses5:i386 libstdc++6:i386 zlib1g:i386 build-essential nodejs \
 	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists /var/cache/apt

# Install gulp
RUN /usr/bin/npm install -g gulp

# Set up environment variables
ENV HOME="/home/user"
ENV	ANDROID_HOME="${HOME}/android-sdk-linux"

ENV	PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}" \
    SDK_URL="https://dl.google.com/android/repository/tools_r25.2.3-linux.zip"

WORKDIR $HOME

# Download Android SDK and update to latest version
RUN  mkdir $ANDROID_HOME \
 	&& curl -o sdk.zip $SDK_URL \
 	&& unzip sdk.zip -d $ANDROID_HOME \
 	&& rm sdk.zip \
 	&& mkdir $ANDROID_HOME/licenses \
 	&& echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license

RUN $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" \
 	&& $ANDROID_HOME/tools/bin/sdkmanager "build-tools;25.0.2" \
 	&& $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-25" "platforms;android-24" \
 	&& $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository"
