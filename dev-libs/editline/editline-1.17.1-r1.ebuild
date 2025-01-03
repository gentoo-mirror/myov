# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="line editing library for UNIX call compatible with the FSF readline"
HOMEPAGE="https://troglobit.com/projects/editline/
	https://github.com/troglobit/editline/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/troglobit/${PN}.git"
else
	SRC_URI="https://github.com/troglobit/${PN}/releases/download/${PV}/${P}.tar.xz"

	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"

PATCHES=(
	"${FILESDIR}/${PN}-1.16.0-rename-man.patch"
)

src_prepare() {
	default

	# To avoid collision with dev-libs/libedit
	# we rename man/editline.3 to man/libeditline.3
	mv man/editline.3 man/libeditline.3 || die
}

src_configure() {
	econf --disable-static
}

src_install() {
	default

	find "${D}" -type f -name "*.la" -delete || die
}
