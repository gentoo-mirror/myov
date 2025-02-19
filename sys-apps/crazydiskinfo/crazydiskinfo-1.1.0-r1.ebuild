# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake custom-cflags flag-o-matic

DESCRIPTION="Interactive TUI S.M.A.R.T viewer for Unix systems"
HOMEPAGE="https://github.com/otakuto/crazydiskinfo/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/otakuto/${PN}/.git"
else
	SRC_URI="https://github.com/otakuto/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/libatasmart:=
	sys-libs/ncurses:=
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	cmake_src_prepare

	sed -i -e "s|set.*||g" ./CMakeLists.txt || die
}

src_configure() {
	custom-cflags_src_configure
	append-cxxflags -std=c++11 -Wall -Wextra

	cmake_src_configure
}

src_install() {
	exeinto /usr/bin
	newexe "${BUILD_DIR}/crazy" "${PN}"

	einstalldocs
}
