VERSION 0.8
FROM docker.io/xgqt/ci-gentoo-tools:3.0.0.current-glibc
WORKDIR /build

setup:
    FROM +base
    ENV FEATURES="-sandbox -ipc-sandbox -mount-sandbox -network-sandbox -pid-sandbox"
    COPY --dir . .

build:
    FROM +setup
    RUN scons build

test:
    FROM +build
    RUN scons test
