FROM adoptopenjdk/openjdk11:aarch64-ubuntu-jdk-11.0.11_9-slim

LABEL description="Android API 31 for CI"
LABEL version="0.4.2"
LABEL maintainer="QAutomatron"

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LINK_ANDROID_SDK=https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip \
    ANDROID_HOME=/opt/android-sdk-linux \
    ANDROID_CMD_ROOT=/opt/cmdline-tools

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_CMD_ROOT}/bin

RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common && \
# Install Deps and build-essential
    # dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --no-install-recommends -y openjdk-8-jdk locales ca-certificates rsync unzip git build-essential curl ruby-dev && \
    locale-gen en_US.UTF-8 && \
    gem install fastlane -NV && \
# Install Android SDK
    curl -L $LINK_ANDROID_SDK > /tmp/android-sdk-linux.zip && \
    unzip -q /tmp/android-sdk-linux.zip -d $ANDROID_CMD_ROOT && \
    rm /tmp/android-sdk-linux.zip
RUN yes | $ANDROID_CMD_ROOT/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --no_https --licenses && \
    yes | $ANDROID_CMD_ROOT/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --install "platforms;android-30" "system-images;android-30;google_apis;arm64-v8a" "build-tools;30.0.3" && \
    mkdir -p /opt/workspace && \
# Clean up
    apt-get -yq autoremove && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /opt/workspace