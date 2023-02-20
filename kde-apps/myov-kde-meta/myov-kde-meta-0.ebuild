# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for KDE packages, custom selection"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X android +accessibility dvd +fonts +graphics vulkan wayland"
RESTRICT="bindist"

RDEPEND="
	app-cdr/dolphin-plugins-mountiso
	kde-apps/ark
	kde-apps/dolphin-plugins-git
	kde-apps/ffmpegthumbs
	kde-apps/kamoso
	kde-apps/kate
	kde-apps/kcalc
	kde-apps/kdialog[X(+)?]
	kde-apps/kompare
	kde-apps/konsole[X(+)?]
	kde-apps/kwalletmanager
	kde-apps/kwave[flac(+),mp3(+),opus(+)]
	kde-apps/okular
	kde-apps/print-manager
	kde-apps/spectacle
	kde-misc/kdirstat
	kde-misc/krename
	kde-plasma/breeze-gtk
	kde-plasma/plasma-browser-integration
	kde-plasma/plasma-meta
	kde-plasma/xdg-desktop-portal-kde
	sys-block/partitionmanager

	app-admin/keepassxc[browser(+)]
	gnome-base/dconf-editor
	media-gfx/simple-scan
	x11-misc/xsensors

	media-libs/mesa[X(+)?,vulkan(+)?,wayland(+)?]
	media-video/ffmpeg[X(+)?,vulkan(+)?]

	|| (
		media-video/mpv
		media-video/vlc[ffmpeg,v4l]
	)
	|| (
		media-sound/strawberry
		media-sound/elisa
		media-sound/cantata
		media-sound/clementine
		media-sound/quodlibet
		media-video/vlc[ffmpeg]
	)
	|| (
		media-sound/kid3
		media-sound/nickvision-tagger
	)
	|| (
		net-p2p/transmission[gtk]
		net-p2p/transmission[qt5]
		net-p2p/ktorrent
		net-p2p/qbittorrent[gui(+)]
	)

	X? (
		x11-apps/xinit
		x11-apps/xkill
		x11-base/xorg-server
	)
	accessibility? ( kde-apps/kdeaccessibility-meta )
	android? ( kde-misc/kdeconnect[X(+)?] )
	dvd? ( kde-apps/k3b[dvd(+)] )
	fonts? (
		media-fonts/cantarell
		media-fonts/cascadia-code
		media-fonts/fontawesome
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
		media-gfx/inkscape
		media-gfx/jpegoptim
		media-gfx/optipng
		media-libs/exiftool
		media-video/handbrake[gtk(+)]
		x11-apps/mesa-progs
	)
	vulkan? (
		dev-util/vulkan-tools
		media-video/libva-utils
	)
	wayland? (
		app-misc/wayland-utils
		sys-apps/xdg-desktop-portal-gtk[X(+)?,wayland(+)]
	)
"
