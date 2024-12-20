# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Tools to access CP/M file systems"
HOMEPAGE="http://www.moria.de/~michael/cpmtools/"
SRC_URI="http://www.moria.de/~michael/${PN}/files/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
IUSE="custom-cflags"

RDEPEND="
	sys-libs/ncurses:=
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	local -x LIBS="$(pkg-config --libs ncurses)"

	econf
}
