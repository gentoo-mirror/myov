# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake custom-cflags xdg

DESCRIPTION="CrystalDiskInfo alternative for Linux"
HOMEPAGE="https://github.com/edisionnano/QDiskInfo/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/edisionnano/QDiskInfo"
else
	SRC_URI="https://github.com/edisionnano/QDiskInfo/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/QDiskInfo-${PV}"

	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,widgets]
"
RDEPEND="
	${DEPEND}
	sys-apps/smartmontools
"

src_configure() {
	custom-cflags_src_configure
	cmake_src_configure
}

src_compile() {
	local -a mycmakeargs=(
		-DINCLUDE_OPTIONAL_RESOURCES="ON"
		-DQT_VERSION_MAJOR="6"
	)
	cmake_src_configure
}
