FROM alpine
ENV FLUTTER_VERSION="3.16.9"
ENV FLUTTER_HOME "/home/bschuele/.flutter-sdk"
ENV PATH $PATH:$FLUTTER_HOME/bin

## Make sure to install gcompat
RUN apk update
RUN apk add bash curl file git unzip which zip gcompat

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

# # Run flutter doctor
RUN flutter doctor

# # Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web