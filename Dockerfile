
ARG REGISTRY
FROM ${REGISTRY}flutter:latest

FROM ubuntu:18.04

# Prerequisites
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget lcov bash jq
RUN apt-get install util-linux

WORKDIR /root

# Prepare Android directories and system variables
RUN mkdir -p /root/Android/sdk
ENV ANDROID_SDK_ROOT /root/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
ENV PATH "$PATH:/root/Android/sdk/platform-tools"
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
RUN cd flutter && git checkout beta
ENV PATH "$PATH:/root/flutter/bin"

RUN flutter doctor

WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
RUN flutter config --enable-web
