# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Implementation of ANSI/MDC Standard M language and database"
HOMEPAGE="https://gitlab.com/Reference-Standard-M/rsm/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://gitlab.com/Reference-Standard-M/rsm"
else
	SRC_URI="https://gitlab.com/Reference-Standard-M/rsm/-/archive/v${PV}/rsm-v${PV}.tar.bz2
		-> ${P}.gl.tar.bz2"
	S="${WORKDIR}/${PN}-v${PV}"

	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="AGPL-3+"
SLOT="0"
IUSE="custom-cflags"

RDEPEND="
	virtual/libcrypt
"
DEPEND="
	${RDEPEND}
"

DOCS=( README.adoc doc/COPYING doc/adoc )

src_prepare() {
	default

	rm ./Makefile || die
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
	local -x CFLAGS="${CFLAGS} ${LDFLAGS}"

	emake CC="$(tc-getCC)"
}

src_install() {
	exeinto /usr/bin
	doexe ./rsm

	insinto /usr/share/rsm
	doins ./*.rsm

	doman ./doc/man/rsm.1

	docompress -x "/usr/share/doc/${P}/adoc"
	einstalldocs
}
