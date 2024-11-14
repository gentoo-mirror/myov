# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Port of OpenBSD's serial terminal emulator cu(1) to Linux"
HOMEPAGE="https://github.com/tobhe/opencu/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/tobhe/${PN}.git"
else
	SRC_URI="https://github.com/tobhe/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}-3-cmake.patch" )

RDEPEND="
	dev-libs/libevent:=
"
DEPEND="
	${RDEPEND}
"
