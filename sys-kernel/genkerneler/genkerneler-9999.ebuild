# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Simple wrapper for genkernel and gentoo utilities"
HOMEPAGE="https://gitlab.com/xgqt/genkerneler"
EGIT_REPO_URI="https://gitlab.com/xgqt/genkerneler.git"

LICENSE="ISC"
SLOT="0"
IUSE=""

RDEPEND="
	app-admin/eselect
	app-shells/bash
	sys-boot/grub
	sys-kernel/genkernel
"
