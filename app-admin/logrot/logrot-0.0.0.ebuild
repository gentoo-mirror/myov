# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Log rotation tool in Python"
HOMEPAGE="https://gitlab.com/xgqt/python-logrot/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/python-${PN}.git"
	S="${S}"/src/${PN}
else
	SRC_URI="https://gitlab.com/xgqt/python-${PN}/-/archive/${PV}/python-${P}.tar.bz2"
	S="${WORKDIR}"/python-${P}/src/${PN}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
