# Copyright (c) 2024-2025, Maciej Barć <xgqt@xgqt.org>

PWD                     := $(shell pwd)

EGENCACHE               := egencache
EMERGE                  := emerge
ENV                     := env
PKGCHECK                := pkgcheck
PKGDEV                  := pkgdev
RM                      := rm  -f -r
SH                      := bash

METADATA                := $(PWD)/metadata
SCAN-CONFIG             := $(METADATA)/pkgcheck.conf

NPROC                   := $(shell nproc || echo 1)

MANIFEST-FLAGS          := --verbose
EGENCACHE-FLAGS         := --jobs $(NPROC) --load-average $(NPROC) --verbose --update
SCAN-FLAGS              := --config $(SCAN-CONFIG) --jobs=$(NPROC) --verbose

.PHONY: all
all:
	$(MAKE) clean
	$(MAKE) test

.PHONY: clean
clean:
	$(RM) $(METADATA)/md5-cache

.PHONY: build
build:
	$(SH) $(PWD)/.aux/admin/build_all.bash

.PHONY: manifests
manifests:
	$(PKGDEV) manifest $(MANIFEST-FLAGS) $(PWD)

.PHONY: cache
cache:
	-$(EGENCACHE) --repo myov $(EGENCACHE-FLAGS)
	$(PKGCHECK) cache --update

.PHONY: test
test: cache manifests
	$(PKGCHECK) scan $(SCAN-FLAGS)
	-$(PKGCHECK) scan $(SCAN-FLAGS) --commits

.PHONY: push
push: test
	$(SH) $(PWD)/.aux/admin/push_all.bash
