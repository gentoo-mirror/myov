# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Roll some dice"
HOMEPAGE="https://gitlab.com/xgqt/dice/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.bz2"

	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
