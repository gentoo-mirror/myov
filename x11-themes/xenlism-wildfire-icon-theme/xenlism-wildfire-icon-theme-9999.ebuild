# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils git-r3

DESCRIPTION="Minimal icon theme for *nix"
HOMEPAGE="http://xenlism.github.io/wildfire/"
EGIT_REPO_URI="https://github.com/xenlism/wildfire.git -> ${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

src_install() {
	mkdir -p "${D}usr/share/icons"
	mv icons/* "${D}usr/share/icons/" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
