# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Small embeddable JavaScript engine"
HOMEPAGE="https://bellard.org/quickjs/
	https://github.com/bellard/quickjs/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/bellard/${PN}.git"
else
	if [[ "${PV}" == 2024.07.27* ]] ; then
		COMMIT="6e2e68fd0896957f92eb6c242a2e048c1ef3cae0"
	else
		die "Unknown COMMIT for version, given: ${PV}"
	fi

	SRC_URI="https://github.com/bellard/${PN}/archive/${COMMIT}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"

	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="MIT"
SLOT="0"

PATCHES=(
	"${FILESDIR}/quickjs-2024.01.13-sharedlib.patch"
)

src_prepare() {
	default

	sed -i Makefile \
		-e '/$(STRIP) .*/d' -e 's;$(PREFIX)/lib;$(LIBDIR);' \
		|| die

	sed -E -i Makefile \
		-e '/^\s*(CC|AR)=/d' \
		|| die
}

src_configure() {
	tc-export AR CC

	export CONFIG_SHARED="y"
	export PREFIX="/usr"
	export LIBDIR="/usr/$(get_libdir)"
}
