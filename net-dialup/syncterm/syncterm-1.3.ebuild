# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop flag-o-matic toolchain-funcs

DESCRIPTION="ANSI-BBS terminal which supports telnet, rlogin, and SSH"
HOMEPAGE="https://syncterm.bbsdev.net/"
SRC_URI="https://sourceforge.net/projects/syncterm/files/syncterm/syncterm-${PV}/syncterm-${PV}-src.tgz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
IUSE="custom-cflags"

RDEPEND="
	sys-libs/ncurses:=
	media-libs/libsdl2
	x11-libs/libX11
"
DEPEND="
	${RDEPEND}
"

DOCS=( src/syncterm/CHANGES )

src_prepare() {
	tc-export AR CC STRIP

	default
}

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	default
}

src_compile() {
	cd "${S}/src/syncterm" || die

	emake USE_SDL="1" USE_SDL_AUDIO="1"
	emake syncterm.man

	# "doman" complains about wrong filename.
	cp ./syncterm.man ./syncterm.1
}

src_install() {
	exeinto /usr/bin
	doexe ./src/syncterm/gcc.linux.x64.exe.debug/syncterm

	local sz=""
	for sz in 16 22 24 32 36 48 64 256 ; do
		doicon --size "${sz}" "./src/syncterm/syncterm${sz}.png"
	done

	doicon --size scalable ./src/syncterm/icons/syncterm.svg
	domenu ./src/syncterm/syncterm.desktop

	doman ./src/syncterm/syncterm.1
	einstalldocs
}
