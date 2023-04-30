# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="CLI interface to GNU Emacs"
HOMEPAGE="https://gitlab.com/xgqt/python-etask/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/python-${PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/python-${PN}/-/archive/${PV}/python-${P}.tar.bz2"
	S="${WORKDIR}"/python-${P}
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"

COMMON_DEPEND="dev-python/colorama[${PYTHON_USEDEP}]"
RDEPEND="
	${COMMON_DEPEND}
	>=app-editors/emacs-23.1:*
"
BDEPEND="
	${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
"

distutils_enable_tests pytest

src_compile() {
	( cd src/${PN} && distutils-r1_src_compile )

	use doc && emake docs
}

src_install() {
	( cd src/${PN} && distutils-r1_src_install )

	dodoc README.md logo.png

	if use doc ; then
		dodoc -r docs/artifacts/{html,latex}
		doman docs/artifacts/man/man3/*
	fi
}
