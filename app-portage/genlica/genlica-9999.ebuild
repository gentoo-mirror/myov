# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Gentoo replica"
HOMEPAGE="https://gitlab.com/xgqt/genlica"
EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="ISC"
SLOT="0"
IUSE="test"

RDEPEND="
	app-admin/stow
	app-portage/cpuid2cpuflags
	sys-apps/portage
"
DEPEND="
	${RDEPEND}
	test? (
		|| (
			dev-util/shellcheck
			dev-util/shellcheck-bin
		)
	)
"

src_prepare() {
	default

	rm LICENSE
	rm -rd .git*
}

src_test() {
	bash test.sh
}

src_install() {
	dodoc README.md

	exeinto "/opt/${PN}"
	doexe check_local create_notmp install uninstall update

	insinto "/opt/${PN}"
	doins -r examples
	doins -r portage
}

pkg_postinst() {
	elog "Now to install the configuration"
	elog "Go to /opt/genlica and run 'bash install'"
}
