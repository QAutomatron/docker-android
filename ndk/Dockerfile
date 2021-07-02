FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u275-b01-slim

LABEL description="Android API 30 for CI"
LABEL version="0.3"
LABEL maintainer="QAutomatron"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

ADD https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip downloaded_sdk.zip

RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common && \
# Install Deps and build-essential
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --no-install-recommends -y locales ca-certificates rsync unzip git build-essential libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 curl ruby-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8 && \
    gem install fastlane -NV && \
    unzip downloaded_sdk.zip -d /opt/android-sdk-linux && \
    rm -f downloaded_sdk.zip && \
    yes | sdkmanager --sdk_root=$ANDROID_HOME --no_https --licenses && \
    yes | sdkmanager --sdk_root=$ANDROID_HOME "build-tools;30.0.3" "platform-tools" "tools" "platforms;android-30" "ndk;21.0.6113669" "ndk;20.0.5594570" "cmake;3.10.2.4988404" && \
    mkdir -p /opt/workspace
WORKDIR /opt/workspace
