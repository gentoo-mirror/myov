# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Funtoo base system tarball bootstrap"
HOMEPAGE="https://gitlab.com/xgqt/funstrap/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-shells/bash
	net-misc/wget
"
