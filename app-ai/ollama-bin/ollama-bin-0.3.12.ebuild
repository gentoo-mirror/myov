# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs

DESCRIPTION="Local runner for LLMs"
HOMEPAGE="https://ollama.com/
	https://github.com/ollama/ollama/"
SRC_URI="
	amd64? (
		https://github.com/ollama/ollama/releases/download/v${PV}/ollama-linux-amd64.tgz
	)
	arm64? (
		https://github.com/ollama/ollama/releases/download/v${PV}/ollama-linux-arm64.tgz
	)
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

CHECKREQS_DISK_BUILD="4G"
QA_PREBUILT="*"

pkg_setup() {
	check-reqs_pkg_setup
}

src_install() {
	insinto "/opt/${P}"
	insopts -m0755
	doins -r bin
	doins -r lib

	dosym -r "/opt/${P}/bin/ollama" "/usr/bin/ollama"
}

pkg_postinst() {
	einfo "Browse available models at: https://ollama.com/library/"
}
