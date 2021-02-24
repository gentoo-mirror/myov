# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils toolchain-funcs

DESCRIPTION="Fork of some suckles projects"
HOMEPAGE="https://gitlab.com/xgqt/mysless"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="
		https://gitlab.com/xgqt/${PN}.git
		https://github.com/xgqt/${PN}.git
	"
else
	SRC_URI="
		https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.gz
		https://github.com/xgqt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="GPL-3 MIT"
SLOT="0"
IUSE="test"

BDEPEND="
	virtual/pkgconfig
	test? (
		|| (
			dev-util/shellcheck
			dev-util/shellcheck-bin
		)
	)
"
RDEPEND="
	>=sys-libs/ncurses-6.0:0=
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"

src_test() {
	bash shellcheck.sh || die "Tests failed"
}

src_compile() {
	tc-export CC

	sh dev.sh --build || die
}

src_install() {
	einstalldocs

	local conflicts="
		usr/bin/awk
		usr/bin/basename
		usr/bin/bc
		usr/bin/cal
		usr/bin/cmp
		usr/bin/dc
		usr/bin/diff
		usr/bin/du
		usr/bin/factor
		usr/bin/fmt
		usr/bin/grep
		usr/bin/join
		usr/bin/look
		usr/bin/md5sum
		usr/bin/seq
		usr/bin/sha1sum
		usr/bin/sleep
		usr/bin/sort
		usr/bin/split
		usr/bin/strings
		usr/bin/tail
		usr/bin/tee
		usr/bin/test
		usr/bin/touch
		usr/bin/tr
		usr/bin/troff
		usr/bin/uniq
		usr/bin/wc
		usr/bin/yacc
		usr/share/man/man1/awk.1
		usr/share/man/man1/basename.1
		usr/share/man/man1/bc.1
		usr/share/man/man1/cal.1
		usr/share/man/man1/cat.1
		usr/share/man/man1/cmp.1
		usr/share/man/man1/date.1
		usr/share/man/man1/dc.1
		usr/share/man/man1/diff.1
		usr/share/man/man1/echo.1
		usr/share/man/man1/ed.1
		usr/share/man/man1/factor.1
		usr/share/man/man1/fmt.1
		usr/share/man/man1/grep.1
		usr/share/man/man1/join.1
		usr/share/man/man1/look.1
		usr/share/man/man1/ls.1
		usr/share/man/man1/mkdir.1
		usr/share/man/man1/rm.1
		usr/share/man/man1/sed.1
		usr/share/man/man1/seq.1
		usr/share/man/man1/sleep.1
		usr/share/man/man1/sort.1
		usr/share/man/man1/split.1
		usr/share/man/man1/tail.1
		usr/share/man/man1/tee.1
		usr/share/man/man1/test.1
		usr/share/man/man1/touch.1
		usr/share/man/man1/tr.1
		usr/share/man/man1/troff.1
		usr/share/man/man1/uniq.1
		usr/share/man/man1/wc.1
	"

	for c in ${conflicts}; do
		rm ./image/"${c}"
	done

	mkdir -p "${D}"
	cp -R image/* "${D}"/
}
