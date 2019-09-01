# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Papirus-folders is a bash script that allows changing the color of folders in Papirus icon theme and its forks"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-folders"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}.git"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	x11-themes/papirus-icon-theme
"
RDEPEND="
	${DEPEND}
"
