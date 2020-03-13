FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u222-b10-slim

LABEL description="Android API 29 for CI"
LABEL version="0.1"
LABEL maintainer="QAutomatron"

RUN apt-get update && apt-get install -y software-properties-common && \
# Install Deps and build-essential
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y locales ca-certificates nano rsync sudo zip git build-essential wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl psmisc module-init-tools python-pip && \
    apt-get clean && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Install Android SDK
ADD https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip downloaded_sdk.zip
RUN unzip downloaded_sdk.zip -d /opt/android-sdk-linux && \
    rm -f downloaded_sdk.zip && \
    mkdir ~/.android && touch ~/.android/repositories.cfg

# Install sdk elements (list from "sdkmanager --list")
RUN yes | sdkmanager --licenses && \
    sdkmanager "build-tools;29.0.2" "platform-tools" "tools" "platforms;android-29" "ndk;21.0.6113669" "cmake;3.10.2.4988404" && \
    sdkmanager --update && \
    yes | sdkmanager --licenses && \
    mkdir -p /opt/workspace
WORKDIR /opt/workspace
