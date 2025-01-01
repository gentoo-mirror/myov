# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit bash-completion-r1 check-reqs cmake flag-o-matic python-single-r1

DESCRIPTION="Paludis, the other package mangler based on EAPI"
HOMEPAGE="https://paludis.exherbolinux.org/
	https://gitlab.exherbo.org/paludis/paludis/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://gitlab.exherbo.org/${PN}/${PN}"
else
	SRC_URI="https://gitlab.exherbo.org/${PN}/${PN}/-/archive/${PV}/${P}.tar.bz2"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
fi

LICENSE="GPL-2+ vim-syntax? ( vim )"
SLOT="0/${PV}"
IUSE="doc custom-cflags pbin python +ruby +search-index test vim-syntax +xml"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="
	sys-apps/file

	search-index? (
		dev-db/sqlite:3
	)
	pbin? (
		app-arch/libarchive:=
	)
	xml? (
		dev-libs/libxml2:=
	)

	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-libs/boost:=[python,${PYTHON_USEDEP}]
		')
	)
	ruby? (
		dev-lang/ruby:*
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	app-text/asciidoc
	app-text/htmltidy
	app-text/xmlto

	doc? (
		app-text/doxygen
	)
	test? (
		dev-cpp/gtest
	)
"

CHECKREQS_DISK_BUILD="410M"

pkg_setup() {
	check-reqs_pkg_setup

	if use python ; then
		python-single-r1_pkg_setup
	fi
}

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	local -a mycmakeargs=(
		# Static features.
		-DBUILD_SHARED_LIBS="ON"
		-DENABLE_STRIPPER="ON"
		-DPALUDIS_COLOUR_PINK="OFF"

		# Documentation.
		-DENABLE_DOXYGEN_TAGS="OFF"
		-DENABLE_PYTHON_DOCS="OFF"
		-DENABLE_RUBY_DOCS="OFF"

		# Features dependent on the USE flags.
		-DENABLE_DOXYGEN="$(usex doc)"
		-DENABLE_GTEST="$(usex test)"
		-DENABLE_PBINS="$(usex pbin)"
		-DENABLE_PYTHON="$(usex python)"
		-DENABLE_RUBY="$(usex ruby)"
		-DENABLE_SEARCH_INDEX="$(usex search-index)"
		-DENABLE_VIM="$(usex vim-syntax)"
		-DENABLE_XML="$(usex xml)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	dobashcomp ./bash-completion/cave

	insinto /usr/share/zsh/site-functions
	doins ./zsh-completion/_cave

	if use python ; then
		python_optimize "${ED}/usr/lib"
	fi

	keepdir /var/lib/exherbo/news
}
