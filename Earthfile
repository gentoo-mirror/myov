VERSION 0.7

FROM docker.io/xgqt/ci-gentoo-tools:amd64-nomultilib-openrc-1.0.0.2023.11.05.23.14

WORKDIR /earthly-build/myov

setup:
    FROM +base

    COPY --dir . .

test:
    FROM +setup

    RUN make test
