# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Simple wrapper for genkernel and gentoo utilities"
HOMEPAGE="https://gitlab.com/xgqt/genkerneler"
EGIT_REPO_URI="https://gitlab.com/xgqt/genkerneler.git"

LICENSE="ISC"
SLOT="0"
IUSE="+genkernel genkernel-next"

RDEPEND="
	|| (
		sys-kernel/genkernel
		sys-kernel/genkernel-next
	)
	genkernel? ( sys-kernel/genkernel )
	genkernel-next? ( sys-kernel/genkernel-next )
	app-admin/eselect
	app-shells/bash
	sys-boot/grub
"
