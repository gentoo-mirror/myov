# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 myov-wrapper

DESCRIPTION="XGQT's dotfiles"
HOMEPAGE="https://gitlab.com/xgqt/mydot"
EGIT_REPO_URI="
	https://gitlab.com/xgqt/${PN}.git
	https://github.com/xgqt/${PN}.git
"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="mirror !test? ( test )"

RDEPEND="
	|| (
		app-admin/pystow
		app-admin/stow
		app-admin/xstow
	)
"
BDEPEND="test? ( || ( dev-util/shellcheck dev-util/shellcheck-bin ) )"

src_install() {
	mkdir -p "${D}"/opt/"${PN}" || die
	cp -r * "${D}"/opt/"${PN}" || die

	make_wrapper "install-mydot" "bash ${EPREFIX}/opt/${PN}/install"

	einstalldocs
}
