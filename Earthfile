VERSION 0.8

FROM docker.io/xgqt/ci-gentoo-tools:1.3.0.current-nomultilib-openrc

WORKDIR /earthly-build/myov

setup:
    FROM +base

    COPY --dir . .

    RUN egencache --jobs 16 --load-average 2 --update
    RUN make deps-versions

test:
    FROM +setup

    RUN make test
