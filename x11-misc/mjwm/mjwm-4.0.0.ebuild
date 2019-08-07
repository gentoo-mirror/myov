# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="mjwm creates JWM application menu from (freedesktop) desktop files"
HOMEPAGE="https://github.com/chiku/mjwm"
SRC_URI="https://github.com/chiku/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~x86-fbsd"

pkg_postinst() {
    elog 'Please note that this program only works with JWM'
    elog 'For more informations see https://github.com/chiku/mjwm'
    elog 'Official JWM GitHub page https://github.com/joewing/jwm'
}