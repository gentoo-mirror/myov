# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit custom-cflags edo toolchain-funcs

DESCRIPTION="Grow Bonsai trees in your terminal"
HOMEPAGE="https://gitlab.com/jallbrit/cbonsai/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://gitlab.com/jallbrit/${PN}"
else
	SRC_URI="https://gitlab.com/jallbrit/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
		-> ${P}.gl.tar.bz2"
	S="${WORKDIR}/${PN}-v${PV}"

	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	sys-libs/ncurses:=
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

DOCS=( README.md )

src_compile() {
	local -a cflags=(
		$(pkg-config --cflags ncursesw panelw)
		$(pkg-config --libs ncursesw panelw)
		${CFLAGS} ${LDFLAGS}
		-Wall -Wcast-qual -Wextra -Wpointer-arith -Wshadow -pedantic
	)
	edo "$(tc-getCC)" "${cflags[@]}" -o "${PN}" "${PN}.c"
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"

	einstalldocs
}
