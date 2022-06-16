# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS=26.1

inherit elisp

DESCRIPTION="Display buffers as PNG images using ansilove in GNU Emacs"
HOMEPAGE="https://gitlab.com/xgqt/emacs-ansilove/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=app-editors/emacs-${NEED_EMACS}[imagemagick]
	media-gfx/ansilove
	media-gfx/imagemagick[png]
"

DOCS=( README.md )

src_compile() {
	emake EMACS="${EMACS}" compile
}

src_install() {
	elisp-install ansilove src/*.el{,c}
	elisp-site-file-install "${S}"/extras/gentoo/50ansilove-gentoo.el

	einstalldocs
}
