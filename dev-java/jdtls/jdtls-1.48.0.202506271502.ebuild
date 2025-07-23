# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAIN_PV="$(ver_cut 1-3)"
TIME_PV="$(ver_cut 4)"

PYTHON_COMPAT=( python3_{12..14} )

inherit java-pkg-2 python-single-r1

DESCRIPTION="Java language server"
HOMEPAGE="https://github.com/eclipse-jdtls/eclipse.jdt.ls/
	https://download.eclipse.org/jdtls/"

SRC_URI="https://download.eclipse.org/jdtls/milestones/${MAIN_PV}/jdt-language-server-${MAIN_PV}-${TIME_PV}.tar.gz"
S="${WORKDIR}"

LICENSE="EPL-2.0"
SLOT="0/${MAIN_PV}"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	>=virtual/jre-1.8:*
	${PYTHON_DEPS}
"

pkg_setup() {
	java-pkg-2_pkg_setup
	python-single-r1_pkg_setup
}

src_install() {
	insinto "/opt/${P}"
	doins -r "${S}"/*

	python_optimize "${ED}/opt/${P}/bin"
	fperms 755 "/opt/${P}/bin"/jdtls{,.bat,.py}
	dosym -r "/opt/${P}/bin/${PN}" "/usr/bin/${PN}"
}
