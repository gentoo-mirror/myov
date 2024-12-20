# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="BASIC to C translator for Unix systems"
HOMEPAGE="https://www.basic-converter.org/
	https://chiselapp.com/user/bacon/repository/bacon/home"

REPO_URI="https://chiselapp.com/user/${PN}/repository/${PN}"
SRC_URI="${REPO_URI}/attachdownload/${P}.tar.gz?page=Downloads&file=${P}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
IUSE="custom-cflags gui"

RDEPEND="
	gui? (
		gui-libs/gtk:4
		gui-libs/gtksourceview:5
	)
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	local -a econfargs=(
		--with-bash
		$(use_enable gui gui-gtk4)
	)

	if ! use gui ; then
		econfargs+=( --disable-gui )
	fi

	econf "${econfargs[@]}"
}

src_compile() {
	emake -j1 STRIP=":" LEGACY="false"
}
