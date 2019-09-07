# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="Papirus icon theme for Linux"
HOMEPAGE="https://git.io/papirus-icon-theme"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}.git"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
