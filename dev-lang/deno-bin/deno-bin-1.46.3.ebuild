# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR="$(ver_cut 1)"

inherit shell-completion

DESCRIPTION="Modern runtime for JavaScript and TypeScript"
HOMEPAGE="https://deno.com/
	https://github.com/denoland/deno/"
SRC_URI="
	amd64? (
		https://github.com/denoland/deno/releases/download/v${PV}/deno-x86_64-unknown-linux-gnu.zip
	)
	arm64? (
		https://github.com/denoland/deno/releases/download/v${PV}/deno-aarch64-unknown-linux-gnu.zip
	)
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0/${MAJOR}"
KEYWORDS="~amd64 ~arm64"

BDEPEND="
	app-arch/unzip
"

QA_PREBUILT="*"

src_compile() {
	mkdir -p completions || die

	./deno completions bash > "completions/deno.bash" || die
	./deno completions zsh  > "completions/deno.zsh"  || die
}

src_install() {
	exeinto /usr/bin
	newexe deno "${P}"
	dosym -r "/usr/bin/${P}" "/usr/bin/deno"

	newbashcomp "completions/deno.bash" "deno"
	newzshcomp "completions/deno.zsh" "_deno"
}
