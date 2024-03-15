VERSION 0.8

FROM docker.io/xgqt/ci-gentoo-tools:latest

WORKDIR /earthly-build/myov

setup:
    FROM +base

    COPY --dir . .

    RUN egencache --jobs 16 --load-average 2 --update

test:
    FROM +setup

    RUN make test
