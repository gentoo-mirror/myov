# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 wrapper

DESCRIPTION="XGQT's dotfiles"
HOMEPAGE="https://gitlab.com/xgqt/mydot"
EGIT_REPO_URI="
	https://gitlab.com/xgqt/${PN}.git
	https://github.com/xgqt/${PN}.git
"

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="GPL-3"
SLOT="0"
IUSE="test"

RDEPEND="
	|| (
		app-admin/pystow
		app-admin/stow
		app-admin/xstow
	)
"
DEPEND="
	test? (
		|| (
			dev-util/shellcheck
			dev-util/shellcheck-bin
		)
	)
"

src_test() {
	bash test.sh || die "Tests failed"
}

src_install() {
	einstalldocs

	mkdir -p "${D}"/opt/"${PN}" || die
	cp -r * "${D}"/opt/"${PN}" || die

	make_wrapper "install-${PN}" "bash ${EPREFIX}/opt/${PN}/install"
}
