# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils unpacker xdg-utils

DESCRIPTION="Flash OS images to SD cards & USB drives, safely and easily."
HOMEPAGE="https://etcher.io/"
SRC_URI="https://github.com/balena-io/${PN}/releases/download/v${PV}/balena-${PN}-electron_${PV}_amd64.deb"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/lzma
	dev-libs/nss
	gnome-base/gconf
	media-libs/alsa-lib
	sys-apps/dbus
	x11-apps/xrandr
	x11-base/xorg-server
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"

QA_PREBUILT="
opt/balenaEtcher/libnode.so
opt/balenaEtcher/libffmpeg.so
opt/balenaEtcher/balena-etcher-electron
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mv * "${D}" || die
	rm -rd "${D}/usr/share/doc/balena-etcher-electron"
	sed -i "s/Utility/System/g" "${D}"usr/share/applications/balena-"${PN}"-electron.desktop
	fperms 0755 /opt/balenaEtcher/balena-"${PN}"-electron || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
