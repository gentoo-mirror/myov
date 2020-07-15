# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Simple information system script"
HOMEPAGE="https://github.com/dylanaraps/neofetch"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	# None fro now
	#SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="X"

RDEPEND="
	sys-apps/pciutils
	X? (
		media-gfx/imagemagick
		media-libs/imlib2
		www-client/w3m[imlib]
		x11-apps/xprop
		x11-apps/xrandr
		x11-apps/xwininfo
	)
"
