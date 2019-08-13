# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="A pretty simple icon theme inspired on material design."
HOMEPAGE="https://drasite.com/flat-remix"
SRC_URI="https://github.com/daniruiz/flat-remix/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P//-icon-theme}"

pkg_preinst () {
	gnome2_icon_savelist
}

pkg_postinst () {
	gnome2_icon_cache_update
}

pkg_postrm () {
	gnome2_icon_cache_update
}