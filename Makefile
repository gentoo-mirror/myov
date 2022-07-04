# Copyright (c) 2021-2022, Maciej Barć <xgqt@riseup.net>
# Licensed under the GNU GPL v2 License


EGENCACHE       := egencache
EMERGE          := emerge
PKGCHECK        := pkgcheck
PKGDEV          := pkgdev
RM              := rm
RMDIR           := $(RM) -r
SH              := sh

MANIFEST        := $(PKGDEV) manifest
SCAN            := $(PKGCHECK) scan

METADATA        := $(PWD)/metadata

SCAN_CONFIG     := $(METADATA)/pkgcheck.conf

NPROC           := $(shell nproc || echo 1)

MANIFEST_FLAGS  := --verbose
EGENCACHE_FLAGS := --jobs $(NPROC) --load-average $(NPROC) --verbose --update
SCAN_FLAGS      := --config $(SCAN_CONFIG) --jobs=$(NPROC) --verbose


all: manifests test


# Regeneration

manifests:
	$(MANIFEST) $(MANIFEST_FLAGS) $(PWD)

egencache:
	PORATGE_REPOSITORIES="[myov] location = $(PWD)" \
		$(EGENCACHE) --repo myov $(EGENCACHE_FLAGS)

clean-metadata-cache:
	$(RMDIR) $(METADATA)/md5-cache

clean: clean-metadata-cache


# Test

test:
	$(SCAN) $(SCAN_FLAGS) $(PWD)


# Auxiliary

deps-versions:
	@$(EMERGE) --version
	@$(PKGCHECK) --version

submodules:
	$(SH) $(PWD)/3rd_party/scripts/src/update-submodules
