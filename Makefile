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
	$(MAKE) manifests
	$(MAKE) test

.PHONY: clean
clean:
	$(RM) $(METADATA)/md5-cache

.PHONY: manifests
manifests:
	$(PKGDEV) manifest $(MANIFEST-FLAGS) $(PWD)

.PHONY: cache
cache:
	$(ENV) PORTAGE_REPOSITORIES="[myov] location = $(PWD)" \
		$(EGENCACHE) --repo myov $(EGENCACHE-FLAGS)

	$(PKGCHECK) cache --update

.PHONY: test
test:
	$(PKGCHECK) scan $(SCAN-FLAGS) $(PWD)
