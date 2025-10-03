# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for KDE packages, custom selection"
HOMEPAGE="https://gitlab.com/xgqt/myov/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+android +accessibility dvd +fonts +graphics vulkan +wayland"
RESTRICT="bindist"

RDEPEND="
	app-cdr/dolphin-plugins-mountiso
	app-cdr/isoimagewriter

	kde-apps/ark
	kde-apps/dolphin-plugins-git
	kde-apps/ffmpegthumbs
	kde-apps/filelight
	kde-apps/kate
	kde-apps/kcalc
	kde-apps/kdenlive
	kde-apps/kdialog
	kde-apps/kompare
	kde-apps/konsole
	kde-apps/kwalletmanager
	kde-apps/kwave[flac(+),mp3(+),opus(+)]
	kde-apps/kwrite
	kde-apps/okular

	kde-misc/kclock
	kde-misc/krename
	kde-misc/kweather

	kde-plasma/breeze-gtk
	kde-plasma/plasma-browser-integration
	kde-plasma/plasma-meta
	kde-plasma/print-manager
	kde-plasma/spectacle
	kde-plasma/xdg-desktop-portal-kde

	media-gfx/krita
	sys-block/partitionmanager

	app-admin/keepassxc[browser(+)]
	gnome-base/dconf-editor
	media-gfx/simple-scan
	media-sound/kid3
	media-video/ffmpeg[vulkan(+)?]
	media-video/obs-studio
	x11-apps/mesa-progs

	|| (
		media-video/smplayer
		media-video/mpv[wayland(+)?]
		media-video/vlc[ffmpeg(+),v4l(+)]
	)
	|| (
		kde-apps/kamoso
		media-video/cheese
	)
	|| (
		media-sound/strawberry
		media-sound/lollypop
		media-sound/elisa
		media-sound/cantata
		media-sound/quodlibet
	)
	|| (
		net-p2p/transmission
		net-p2p/ktorrent
		net-p2p/qbittorrent[gui(+)]
	)

	accessibility? (
		kde-apps/kdeaccessibility-meta
	)
	android? (
		kde-misc/kdeconnect
	)
	dvd? (
		kde-apps/k3b[dvd(+)]
	)
	fonts? (
		media-fonts/cantarell
		media-fonts/cascadia-code
		media-fonts/dejavu
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
		media-gfx/inkscape
		media-gfx/jpegoptim
		media-gfx/optipng
		media-gfx/rawtherapee
		media-libs/exiftool
	)
	vulkan? (
		dev-util/vulkan-tools
		media-video/libva-utils
	)
	wayland? (
		app-misc/wayland-utils
	)
"
