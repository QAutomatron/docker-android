FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u292-b10-slim

LABEL description="Android API 31 for CI"
LABEL version="0.4.1"
LABEL maintainer="QAutomatron"

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LINK_ANDROID_SDK=https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip \
    ANDROID_HOME=/opt/android-sdk-linux \
    ANDROID_CMD_ROOT=/opt/cmdline-tools \
    PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_CMD_ROOT/bin"

RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common && \
# Install Deps and build-essential
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --no-install-recommends -y locales ca-certificates rsync unzip git build-essential libc6-i386 lib32stdc++6 lib32gcc1 lib32z1 curl ruby-dev && \
    locale-gen en_US.UTF-8 && \
    gem install fastlane -NV && \
# Install Android SDK
    curl -L $LINK_ANDROID_SDK > /tmp/android-sdk-linux.zip && \
    unzip -q /tmp/android-sdk-linux.zip -d $ANDROID_CMD_ROOT && \
    rm /tmp/android-sdk-linux.zip && \
    yes | $ANDROID_CMD_ROOT/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --no_https --licenses && \
    yes | $ANDROID_CMD_ROOT/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;30.0.3" "platform-tools" "tools" "platforms;android-31" && \
    mkdir -p /opt/workspace && \
# Clean up
    apt-get -yq autoremove && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /opt/workspace