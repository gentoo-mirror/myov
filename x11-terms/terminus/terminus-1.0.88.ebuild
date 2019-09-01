# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg-utils

DESCRIPTION="A terminal for a more modern age"
HOMEPAGE="https://eugeny.github.io/terminus"
SRC_URI="https://github.com/Eugeny/${PN}/releases/download/v${PV}/${P}-linux.deb"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    app-crypt/libsecret
    dev-libs/libappindicator
	dev-libs/nss
    gnome-base/gconf
    x11-libs/libnotify
    x11-libs/libXtst
"

QA_PREBUILT="
    /opt/Terminus/${PN}
    /opt/Terminus/swiftshader/libGLESv2.so
    /opt/Terminus/swiftshader/libEGL.so
    /opt/Terminus/libffmpeg.so
    /opt/Terminus/libGLESv2.so
    /opt/Terminus/libEGL.so
"

S="${WORKDIR}"

src_unpack() {
    unpack_deb ${A}
}

src_install() {
    mv * "${D}" || die
    rm -rd "${D}usr/share/doc/terminus"
    sed -i "s/Utilities/System/g" "${D}usr/share/applications/${PN}.desktop"
    dosym "/opt/Terminus/terminus" "/usr/bin/terminus"
}

pkg_postinst() {
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_icon_cache_update
}
