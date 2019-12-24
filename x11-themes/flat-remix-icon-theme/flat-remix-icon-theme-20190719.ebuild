# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="A pretty simple icon theme inspired on material design."
HOMEPAGE="https://drasite.com/flat-remix"
SRC_URI="https://github.com/daniruiz/flat-remix/archive/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${P//-icon-theme}"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
