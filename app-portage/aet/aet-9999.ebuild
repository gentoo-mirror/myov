# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="APT-like wrapper for portage with helpful additions"
HOMEPAGE="https://gitlab.com/xgqt/aet"
EGIT_REPO_URI="https://gitlab.com/xgqt/aet.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="
	app-portage/eix
	app-portage/gentoolkit
	sys-apps/portage
	virtual/editor
"
