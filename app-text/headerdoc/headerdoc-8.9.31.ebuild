# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR="$(ver_cut 1)"

inherit toolchain-funcs

DESCRIPTION="Engine processing comments from source code and header files"
HOMEPAGE="https://github.com/apple-oss-distributions/headerdoc/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_BRANCH="rel/headerdoc-${MAJOR}"
	EGIT_REPO_URI="https://github.com/apple-oss-distributions/${PN}.git"
else
	SRC_URI="https://github.com/apple-oss-distributions/${PN}/archive/refs/tags/${P}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/${PN}-${P}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="APSL-2"
SLOT="0/${MAJOR}"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libxml2
	dev-perl/HTML-Parser
"
BDEPEND="
	test? (
		dev-perl/FreezeThaw
	)
"

src_configure() {
	tc-export CC
}

src_compile() {
	cd xmlman || die
	emake -j1 CC="${CC}"
}

src_test() {
	nonfatal emake test
}

src_install() {
	emake DSTROOT="${D}" installsub

	einstalldocs
}
