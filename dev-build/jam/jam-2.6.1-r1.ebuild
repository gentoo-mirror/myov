# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="make(1) redux, build utility based on Make"
HOMEPAGE="https://swarm.workshop.perforce.com/projects/perforce_software-jam/"
SRC_URI="https://swarm.workshop.perforce.com/downloads/guest/perforce_software/jam/${P}.tar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
IUSE="custom-cflags"

PATCHES=(
	"${FILESDIR}/jam-2.6.1-jamfile-bin.patch"
	"${FILESDIR}/jam-2.6.1-makefile-cc.patch"
)

DOCS=( Jam.html Jambase.html Jamfile.html README RELNOTES )

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	tc-export AR CC RANLIB

	default
}

src_compile() {
	local _cflags="${CFLAGS} -std=c89 ${LDFLAGS}"
	local _ar="${AR} ${ARFLAGS} ru"

	emake AR="${_ar}" CC="${CC}" RANLIB="${RANLIB}" \
		  CFLAGS="${_cflags}" CCFLAGS="${_cflags}"
}

src_install() {
	exeinto /usr/bin
	doexe ./bin/jam

	einstalldocs
}
