# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop xdg

DESCRIPTION="'Quick' - Emacs pseudo-distribution (in ebuild form only)"
HOMEPAGE="https://gitlab.com/xgqt/myov"

# Yes, we generate this thing in the ebuild only...
# Crazy, right? ;D
SRC_URI=""
KEYWORDS="~amd64"

RESTRICT="
	fetch
	test
"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	app-editors/emacs
"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	# In /usr/bin/qmacs this looks... interesting
	make_wrapper "${PN}" \
		      "emacs -Q -nw \
			     --eval '(setq
					auto-save-default nil
					create-lockfiles nil
					make-backup-files nil
					scroll-conservatively 100
					x-select-enable-clipboard-manager nil
					column-number-mode t
					)'"
	make_desktop_entry "${PN}" "${PN^}" "emacs" \
					   "Development;TextEditor;" "Terminal=true"
}
