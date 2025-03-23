# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit custom-cflags cmake xdg

DESCRIPTION="Desktop panel for Linux desktop, supports KDE 6 and LXQt on Wayland"
HOMEPAGE="https://github.com/dangvd/crystal-dock/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/dangvd/${PN}"
else
	SRC_URI="https://github.com/dangvd/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/${P}/src"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"
RESTRICT="test"  # Fails tests.

RDEPEND="
	dev-libs/wayland
	dev-qt/qtbase:6[dbus,gui,widgets]
	kde-plasma/layer-shell-qt:6
	x11-libs/libxkbcommon
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	custom-cflags_src_configure
	cmake_src_configure
}

src_test() {
	:
}
