# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3 wrapper

DESCRIPTION="Gentoo replica"
HOMEPAGE="https://gitlab.com/xgqt/genlica"
EGIT_REPO_URI="
	https://gitlab.com/xgqt/${PN}.git
	https://github.com/xgqt/${PN}.git
"

RESTRICT="
	binchecks mirror strip
	!test? ( test )
"
LICENSE="ISC"
SLOT="0"
IUSE="test"

RDEPEND="
	app-portage/cpuid2cpuflags
	sys-apps/portage
	|| (
		app-admin/pystow
		app-admin/stow
		app-admin/xstow
	)
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

src_test() {
	bash test.sh || die "Tests failed"
}

src_install() {
	einstalldocs

	dobin update-genlica

	exeinto "/opt/${PN}"
	rm test.sh || die
	for exe in *
	do
		if [ ! -d "${exe}" ] && [ -x "${exe}" ]
		then
			echo "[I] Installing ${exe}"
			doexe "${exe}"
			make_wrapper "${PN}-${exe}" "${EPREFIX}/opt/${PN}/${exe}"
		fi
	done

	insinto "/opt/${PN}"
	doins -r examples
	doins -r portage
}

pkg_postinst() {
	elog "Now to install the configuration"
	elog "Go to /opt/genlica and run 'bash install'"
	elog "or run 'emerge --config genlica'"
	elog "You can also run 'update-genlica' to update genlica"
}

pkg_config() {
	bash "${EPREFIX}"/opt/genlica/install
}
