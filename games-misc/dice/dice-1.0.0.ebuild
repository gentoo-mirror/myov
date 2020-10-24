# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Roll some dice"
HOMEPAGE="https://gitlab.com/xgqt/dice"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	SRC_URI="
		https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.gz
		https://github.com/xgqt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
