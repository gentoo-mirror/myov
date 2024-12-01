# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Traditional interpreter for the BASIC language"
HOMEPAGE="https://2484.de/yabasic/"
SRC_URI="https://2484.de/yabasic/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
IUSE="X +ffi"

RDEPEND="
	sys-libs/ncurses:=

	X? (
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libxcb:=
	)
	ffi? (
		dev-libs/libffi:=
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local -x LIBS="$(pkg-config --libs ncurses)"

	local -a econfargs=(
		$(use_with X x)
		$(use_with ffi)
	)
	econf "${econfargs[@]}"
}
