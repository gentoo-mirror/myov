# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for KDE packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+accessibility +fonts +graphics"

RDEPEND="
	app-cdr/dolphin-plugins-mountiso
	kde-apps/ark
	kde-apps/dolphin-plugins-git
	kde-apps/ffmpegthumbs
	kde-apps/kamoso
	kde-apps/kate
	kde-apps/kcalc
	kde-apps/kdialog
	kde-apps/kompare
	kde-apps/konsole
	kde-apps/kwalletmanager
	kde-apps/okular
	kde-apps/spectacle
	kde-misc/kdirstat
	kde-misc/krename
	kde-plasma/breeze-gtk
	kde-plasma/plasma-meta
	accessibility? (
		kde-apps/kdeaccessibility-meta
	)
	fonts? (
		media-fonts/cantarell
		media-fonts/droid
		media-fonts/fontawesome
		media-fonts/hack
		media-fonts/jetbrains-mono
		media-fonts/noto-cjk
		media-fonts/noto-emoji
		media-fonts/open-sans
		media-fonts/powerline-symbols
		media-fonts/roboto
	)
	graphics? (
		kde-apps/gwenview
		kde-apps/kdegraphics-meta
		media-gfx/darktable
		media-gfx/gimp
		media-gfx/inkscape
		media-gfx/jpegoptim
		media-gfx/optipng
	)
"
