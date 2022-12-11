# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="grateful_dead_lyrics"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fortune modules from the Grateful Gead song lyrics"
HOMEPAGE="https://gitlab.com/xgqt/grateful_dead_lyrics"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${MY_PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${MY_PN}/-/archive/${PV}/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="games-misc/fortune-mod"
BDEPEND="${RDEPEND}"
