# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker xdg-utils

DESCRIPTION="Elegant Facebook Messenger desktop app."
HOMEPAGE="https://sindresorhus.com/caprine/"
SRC_URI="https://github.com/sindresorhus/${PN}/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf
	x11-libs/libnotify
	x11-libs/libXtst
"

RDEPEND="${DEPEND}"

QA_PREBUILT="
	/opt/Caprine/swiftshader/libEGL.so
	/opt/Caprine/swiftshader/libGLESv2.so
	/opt/Caprine/libEGL.so
	/opt/Caprine/libffmpeg.so
	/opt/Caprine/caprine
	/opt/Caprine/libGLESv2.so
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mv * "${D}" || die
	rm -rd "${D}usr/share/doc/caprine"
	dosym "/opt/Caprine/caprine" "/usr/bin/caprine"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
