# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Funtoo base system bootstrap"
HOMEPAGE="https://gitlab.com/xgqt/funstrap"
EGIT_REPO_URI="https://gitlab.com/xgqt/funstrap.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="
	app-shells/bash
	net-misc/wget
"
