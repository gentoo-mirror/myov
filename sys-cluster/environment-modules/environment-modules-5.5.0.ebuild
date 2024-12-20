# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit flag-o-matic python-r1

DESCRIPTION="Environment Modules provide dynamic modification of user environment"
HOMEPAGE="https://envmodules.github.io/modules/
	https://github.com/envmodules/modules/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/envmodules/modules.git"
else
	SRC_URI="https://github.com/envmodules/modules/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/modules-${PV}"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
fi

LICENSE="GPL-2+"
SLOT="0/${PV}"
IUSE="custom-cflags test"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}

	dev-lang/tcl
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	${RDEPEND}

	test? (
		dev-tcltk/expect
		dev-util/dejagnu
	)
"
PDEPEND="
	virtual/editor
	virtual/pager
"

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	local -a myconf=(
		--with-verbosity="normal"

		--etcdir="/etc/environment-modules"
		--initdir="/usr/share/modules/init"
		--modulefilesdir="/usr/share/modules/modulefiles"

		--with-editor="${EPREFIX}/usr/libexec/editor"
		--with-pager="${EPREFIX}/usr/libexec/pager"

		--enable-new-features
	)
	econf "${myconf[@]}"
}

src_compile() {
	local -x V="1"

	default
}

src_install() {
	default

	python_foreach_impl python_optimize "${ED}/usr/share"
}
