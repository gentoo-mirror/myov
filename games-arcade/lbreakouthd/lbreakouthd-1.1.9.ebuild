# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

LB_LEVELS_V="20160512"
LB_THEMES_V="20160512"

DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/LBreakoutHD/"
SRC_URI="
	https://sourceforge.net/projects/lgames/files/${PN}/${P}.tar.gz
	https://sourceforge.net/projects/lgames/files/add-ons/lbreakout2/lbreakout2-levelsets-${LB_LEVELS_V}.tar.gz
	themes? (
		https://sourceforge.net/projects/lgames/files/add-ons/lbreakout2/lbreakout2-themes-${LB_THEMES_V}.tar.gz
	)
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+nls +themes"

RDEPEND="
	acct-group/gamestat
	media-libs/libpng:=
	media-libs/libsdl2[joystick,sound,video]
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-net
	media-libs/sdl2-ttf
	sys-libs/zlib:=

	nls? (
		virtual/libintl
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	nls? (
		sys-devel/gettext
	)
	themes? (
		app-arch/unzip
	)
"

src_unpack() {
	unpack "${P}.tar.gz"

	cd "${S}/src/levels" || die
	unpack "lbreakout2-levelsets-${LB_LEVELS_V}.tar.gz"

	if use themes ; then
		mkdir -p "${WORKDIR}/themes" || die
		cd "${WORKDIR}/themes" || die
		unpack "lbreakout2-themes-${LB_THEMES_V}.tar.gz"

		# Do not overwrite the main themes.
		rm -f ./absoluteB.zip ./oz.zip ./moiree.zip || die

		local f=""
		for f in ./*.zip; do
			unpack "./${f}"
			rm -r "./${f}" || die
		done
	fi
}

src_configure() {
	local -a econfargs=(
		$(use_enable nls)
		--localstatedir="${EPREFIX}/var/games"
	)
	econf "${econfargs[@]}"
}

src_install() {
	default

	make_desktop_entry "${PN}" LBreakoutHD lbreakouthd256

	if use themes ; then
		insinto /usr/share/lbreakouthd/themes
		doins -r "${WORKDIR}/themes/."
	fi

	fowners :gamestat "/usr/bin/${PN}" "/var/games/${PN}.hscr"
	fperms g+s "/usr/bin/${PN}"
	fperms 660 "/var/games/${PN}.hscr"
}
