# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit custom-cflags edo toolchain-funcs

DESCRIPTION="Bywater interpreter for the BASIC programming language"
HOMEPAGE="https://sourceforge.net/projects/bwbasic/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.zip"
S="${WORKDIR}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

BDEPEND="
	app-arch/unzip
	app-text/dos2unix
"

PATCHES=(
	"${FILESDIR}/bwbasic-3.30-Makefile-in.patch"
	"${FILESDIR}/bwbasic-3.30-bwb_cmd-c.patch"
)

DOCS=( README )

src_prepare() {
	edo chmod +x ./configure
	edo dos2unix ./Makefile.in ./bwb_cmd.c ./configure

	default
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="-Wall -Wextra -ansi ${CFLAGS} ${LDFLAGS}"
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
	newexe renum "${PN}-renum"

	docompress -x "/usr/share/doc/${PF}/docs/"
	docinto docs
	dodoc ./DOCS/*

	einstalldocs

	elog "The 'renum' program is installed as '${PN}-renum'."
}
