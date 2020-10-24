# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Simple wrapper for make, dracut and gentoo utilities"
HOMEPAGE="https://gitlab.com/xgqt/kerneler"
EGIT_REPO_URI="https://gitlab.com/xgqt/kerneler.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="
	app-admin/eselect
	app-shells/bash
	sys-boot/grub
	sys-kernel/dracut
"
