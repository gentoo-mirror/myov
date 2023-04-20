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
	kde-apps/filelight
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
	kde-misc/krename
	kde-plasma/breeze-gtk
	kde-plasma/plasma-browser-integration
	kde-plasma/plasma-meta
	kde-plasma/xdg-desktop-portal-kde
	sys-block/partitionmanager

	app-admin/keepassxc[X(+)?,browser(+)]
	gnome-base/dconf-editor
	media-gfx/simple-scan
	media-sound/kid3
	media-video/ffmpeg[X(+)?,vulkan(+)?]
	x11-apps/mesa-progs

	|| (
		media-video/mpv[X(+)?]
		media-video/vlc[X(+)?,ffmpeg(+),v4l(+)]
	)
	|| (
		media-sound/strawberry
		media-sound/elisa
		media-sound/cantata
		media-sound/clementine
		media-sound/quodlibet
		media-video/vlc[X(+)?,ffmpeg(+)]
	)
	|| (
		net-p2p/transmission[qt5]
		net-p2p/transmission[gtk]
		net-p2p/ktorrent
		net-p2p/qbittorrent[gui(+)]
	)

	X? (
		x11-apps/xinit
		x11-apps/xkill
		x11-base/xorg-server
		x11-apps/xinput
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
		kde-apps/gwenview[X(+)?]
		kde-apps/kdegraphics-meta
		media-gfx/inkscape[X(+)?]
		media-gfx/jpegoptim
		media-gfx/optipng
		media-libs/exiftool
		media-video/handbrake[gtk(+)]
	)
	vulkan? (
		dev-util/vulkan-tools
		media-video/libva-utils
	)
	wayland? ( app-misc/wayland-utils )
"
