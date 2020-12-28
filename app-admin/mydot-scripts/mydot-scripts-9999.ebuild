# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="System-wide installation of scripts from mydot"
HOMEPAGE="https://gitlab.com/xgqt/mydot"
EGIT_REPO_URI="
	https://gitlab.com/xgqt/mydot.git
	https://github.com/xgqt/mydot.git
"

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="GPL-3"
SLOT="0"
IUSE="test"

DEPEND="
	test? (
		|| (
			dev-util/shellcheck
			dev-util/shellcheck-bin
		)
	)
"

src_test() {
	bash test.sh || die "Tests failed"
}

src_install() {
	pushd scripts/.local/share/bin

	local script
	for script in *
	do
		dobin "${script}"
	done

	popd
}
