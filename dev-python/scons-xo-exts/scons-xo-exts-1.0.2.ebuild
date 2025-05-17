# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

REAL_PN="xgqt-python-lib-${PN}"
MAJOR="$(ver_cut 1)"

DISTUTILS_USE_PEP517="flit"
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Extensions for SCons, includes Python libraries and builders"
HOMEPAGE="https://gitlab.com/xgqt/xgqt-python-lib-scons-xo-exts/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://gitlab.com/xgqt/${REAL_PN}"
else
	SRC_URI="https://gitlab.com/xgqt/${REAL_PN}/-/archive/${PV}/${REAL_PN}-${PV}.tar.bz2
		-> ${REAL_PN}-${PV}.gl.tar.bz2"

	KEYWORDS="~amd64 ~x86"
fi

S="${WORKDIR}/${REAL_PN}-${PV}/code/source/v${MAJOR}/${PN}-lib"

LICENSE="MPL-2.0"
SLOT="0/${MAJOR}"

RDEPEND="
	dev-build/scons[${PYTHON_USEDEP}]
"
