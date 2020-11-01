# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="APT-like wrapper for portage with helpful additions"
HOMEPAGE="https://gitlab.com/xgqt/aet"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="
		https://gitlab.com/xgqt/${PN}.git
		https://github.com/xgqt/${PN}.git
	"
else
	SRC_URI="
		https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.gz
		https://github.com/xgqt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="ISC"
SLOT="0"

RDEPEND="
	app-portage/eix
	app-portage/gentoolkit
	sys-apps/portage
	virtual/editor
"
