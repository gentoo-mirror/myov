# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Simple wrapper for genkernel and gentoo utilities."
HOMEPAGE="https://gitlab.com/xgqt/genkerneler"
EGIT_REPO_URI="https://gitlab.com/xgqt/genkerneler.git"

LICENSE="MIT"
SLOT="0"

DEPEND="
    app-admin/eselect
    app-shells/bash
    sys-boot/grub
"

RDEPEND="${DEPEND}"
