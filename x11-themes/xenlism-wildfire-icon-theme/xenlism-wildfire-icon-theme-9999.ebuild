# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 xdg-utils

DESCRIPTION="Minimal icon theme for *nix"
HOMEPAGE="http://xenlism.github.io/wildfire/"
EGIT_REPO_URI="https://github.com/xenlism/wildfire.git -> ${P}"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	mkdir -p "${D}/usr/share/icons"
	mv icons/* "${D}/usr/share/icons/" || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
