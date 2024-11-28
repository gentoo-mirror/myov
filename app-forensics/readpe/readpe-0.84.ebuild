# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Multiplatform command line toolkit to work with PE binaries"
HOMEPAGE="https://github.com/mentebinaria/readpe/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/mentebinaria/${PN}"
else
	SRC_URI="https://github.com/mentebinaria/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"

PATCHES=(
	"${FILESDIR}/readpe-0.84-libpe-makefile.patch"
	"${FILESDIR}/readpe-0.84-src-makefile.patch"
)

src_prepare() {
	sed -i \
		-e "/^libdir/s|\([^=]*\).*\$|\1= /usr/$(get_libdir)|" \
		src/Makefile \
		lib/libpe/Makefile \
		|| die

	tc-export CC

	default
}

src_compile() {
	emake CC="$(tc-getCC)"
}
