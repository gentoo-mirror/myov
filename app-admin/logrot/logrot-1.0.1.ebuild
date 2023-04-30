# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Log rotation tool in Python"
HOMEPAGE="https://gitlab.com/xgqt/python-logrot/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/python-${PN}.git"
	S="${S}"/src/${PN}
else
	SRC_URI="https://gitlab.com/xgqt/python-${PN}/-/archive/${PV}/python-${P}.tar.bz2"
	S="${WORKDIR}"/python-${P}/src/${PN}-tool
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
