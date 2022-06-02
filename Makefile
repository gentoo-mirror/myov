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

NPROC           := $(shell nproc || echo 1)
MANIFEST_FLAGS  := --verbose

EGENCACHE_AUX   := --jobs $(NPROC) --load-average $(NPROC) --verbose
EGENCACHE_REPO  := myov
EGENCACHE_FLAGS := $(EGENCACHE_AUX) --update --repo $(EGENCACHE_REPO)

SCAN_AUX        := --jobs=$(NPROC) --verbose
SCAN_EXIT_ON    := error
SCAN_KEYWORDS   := -MatchingChksums,-RedundantVersion
SCAN_PROFILES   := default/linux/amd64/17.1
SCAN_CHECKS     := --exit=$(SCAN_EXIT_ON) --keywords=$(SCAN_KEYWORDS) --profiles=$(SCAN_PROFILES)
SCAN_FLAGS      := $(SCAN_AUX) $(SCAN_CHECKS)


all: manifests test


# Regeneration

manifests:
	$(MANIFEST) $(MANIFEST_FLAGS) $(PWD)

egencache:
	$(EGENCACHE) $(EGENCACHE_FLAGS)

clean-metadata-cache:
	$(RMDIR) $(PWD)/metadata/md5-cache

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
