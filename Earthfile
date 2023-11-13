VERSION 0.7

FROM docker.io/xgqt/ci-gentoo-tools:amd64-nomultilib-openrc-1.1.0.current

WORKDIR /earthly-build/myov

setup:
    FROM +base

    COPY --dir . .

    RUN make deps-versions

test:
    FROM +setup

    RUN make test
