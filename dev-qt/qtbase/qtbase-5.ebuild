# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for Qt5-base"
HOMEPAGE="https://www.qt.io/"
SRC_URI=""

LICENSE="metapackage"
SLOT="5"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtconcurrent:${SLOT}
	dev-qt/qtcore:${SLOT}
	dev-qt/qtdbus:${SLOT}
	dev-qt/qtgui:${SLOT}
	dev-qt/qtnetwork:${SLOT}
	dev-qt/qtopengl:${SLOT}
	dev-qt/qtprintsupport:${SLOT}
	dev-qt/qtsql:${SLOT}
	dev-qt/qttest:${SLOT}
	dev-qt/qtwidgets:${SLOT}
	dev-qt/qtxml:${SLOT}
"
