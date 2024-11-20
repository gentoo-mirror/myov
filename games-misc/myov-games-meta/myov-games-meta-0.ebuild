# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for miscellaneous open-source desktop games"
HOMEPAGE="https://gitlab.com/xgqt/myov/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+kde"
RESTRICT="bindist"

# TODO: Find clones: bejeweled, billiard, space cadet (pinball), zuma.
# TODO: Replace those KDE games: granatier.

RDEPEND="
	games-arcade/gnome-nibbles
	games-board/gnome-mahjongg
	games-board/gnome-mines
	games-puzzle/gnome-sudoku
	games-puzzle/gnome2048
	games-puzzle/quadrapassel

	kde? (
		kde-apps/kapman
		kde-apps/knavalbattle
		kde-apps/knights
		kde-apps/kpat
		kde-apps/kdiamond
	)
"
