# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for KDE packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+accessibility +fonts +graphics pulseaudio vulkan"
RESTRICT="bindist"

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
	kde-apps/kwave
	kde-apps/okular
	kde-apps/spectacle
	kde-misc/kdirstat
	kde-misc/krename
	kde-plasma/breeze-gtk
	kde-plasma/discover[firmware(+)]
	kde-plasma/plasma-meta[browser-integration(+),desktop-portal(+),smart(+)]
	kde-plasma/plasma-meta[pulseaudio?]

	app-admin/keepassxc[browser(+)]
	media-sound/kid3

	app-admin/system-config-printer
	gnome-base/dconf-editor
	media-gfx/simple-scan
	net-p2p/transmission
	x11-misc/xsensors

	|| (
		media-video/vlc[ffmpeg,pulseaudio?,v4l]
		media-video/mpv[pulseaudio?]
	)

	accessibility? (
		kde-apps/kdeaccessibility-meta
	)
	fonts? (
		media-fonts/cantarell
		media-fonts/cascadia-code
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
		media-libs/exiftool
		media-video/handbrake[gtk(+)]
		x11-apps/mesa-progs
	)
	pulseaudio? (
		media-sound/paprefs
		media-sound/pavucontrol
	)
	vulkan? (
		dev-util/vulkan-tools
		media-libs/mesa[vulkan(+)]
		media-video/ffmpeg[vulkan(+)]
		media-video/libva-utils
	)
"
