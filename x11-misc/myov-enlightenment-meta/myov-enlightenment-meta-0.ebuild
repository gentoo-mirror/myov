# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Enlightenment packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist"

RDEPEND="
	dev-libs/efl[drm(+),gstreamer(+)]
	x11-wm/enlightenment[acpid(+),exif(+),udisks(+)]

	app-editors/ecrire
	dev-util/edi
	media-gfx/entice
	media-gfx/ephoto
	media-video/rage
	sys-process/evisum
	x11-terms/terminology
	x11-themes/e-gtk-theme

	sys-power/acpid
"

pkg_postinst() {
	# Ensure acpid is running
	if type rc-update >/dev/null ; then
		rc-update add acpid default
	elif type systemctl >/dev/null ; then
		systemctl enable acpid
	fi
}
