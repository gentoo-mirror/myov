# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="SVG icon theme from the Fedora Echo Icon project"
HOMEPAGE="https://fedorahosted.org/echo-icon-theme"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="
	binchecks mirror strip
	!test? ( test )
"
LICENSE="CC-BY-SA-3.0"
SLOT="0"
IUSE="test"

BDEPEND="
	virtual/pkgconfig
	>=x11-misc/icon-naming-utils-0.8.90
"
