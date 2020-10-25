# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop wrapper xdg

DESCRIPTION="XGQT's Emacs config aimed at Windows"
HOMEPAGE="https://gitlab.com/xgqt/wmacs"

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
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-editors/emacs
"

src_install() {
	einstalldocs

	insinto /opt/wmacs
	doins init.el

	exeinto /opt/wmacs
	doexe *.sh

	make_wrapper "${PN}" "sh ${EPREFIX}/opt/${PN}/launch.sh"
	make_desktop_entry "${PN}" "${PN^}" "emacs" "Development;TextEditor;"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
