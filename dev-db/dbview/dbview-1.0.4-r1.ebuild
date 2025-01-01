# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="View dBase III files"
HOMEPAGE="https://www.infodrom.org/projects/dbview/"
SRC_URI="https://www.infodrom.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
IUSE="custom-cflags"

DOCS=( CHANGES README dBASE )

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	default
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${LDFLAGS}"
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"

	doman "${PN}.1"

	einstalldocs
}
