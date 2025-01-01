# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="https://dev.yorhel.nl/ncdu"
SRC_URI="https://dev.yorhel.nl/download/ncdu-${PV}.tar.gz"
S="${WORKDIR}/ncdu-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
IUSE="custom-cflags"

DEPEND="
	sys-libs/ncurses:=[unicode(+)]
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	default
}

src_install() {
	exeinto /usr/bin
	newexe ./ncdu ncdu-c

	newman ./ncdu.1 ncdu-c.1

	einstalldocs
}
