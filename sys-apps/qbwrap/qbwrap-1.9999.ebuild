# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR=$(ver_cut 1)

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Quick Bubblewrap chroot management tool"
HOMEPAGE="https://gitlab.com/xgqt/xgqt-python-app-qbwrap/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/xgqt-python-app-${PN}.git"
	S="${WORKDIR}"/${P}/Source/v${MAJOR}/${PN}-app
else
	SRC_URI="https://gitlab.com/xgqt/xgqt-python-app-${PN}/-/archive/${PV}/xgqt-python-app-${P}.tar.bz2"
	S="${WORKDIR}"/xgqt-python-app-${P}/Source/v${MAJOR}/${PN}-app
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MPL-2.0"
SLOT="0/${MAJOR}"

RDEPEND="
	dev-python/tomli
"
BDEPEND="
	${RDEPEND}
	sys-apps/texinfo
"

DOCS=( README.md )

distutils_enable_tests pytest

src_compile() {
	distutils-r1_src_compile

	cd ../${PN}-info || die
	makeinfo ${PN}.texi || die
}

src_test() {
	cd ../${PN}-app-test || die
	distutils-r1_src_test
}

src_install() {
	distutils-r1_src_install

	doinfo ../${PN}-info/${PN}.info
	dodoc -r ../${PN}-examples/Examples

	einstalldocs
}
