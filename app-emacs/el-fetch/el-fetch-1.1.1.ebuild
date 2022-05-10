# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=emacs-${PN}
MY_P=${MY_PN}-${PV}

NEED_EMACS=25.1

inherit elisp

DESCRIPTION="Show system information in Neofetch-like style (eg CPU, RAM) inside Emacs"
HOMEPAGE="https://gitlab.com/xgqt/emacs-el-fetch/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${MY_PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${MY_PN}/-/archive/${PV}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( app-emacs/buttercup )"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	elisp_src_prepare

	sed "s|#!emacs|#!${EPREFIX}/usr/bin/emacs|" -i extras/${PN}-console || die
}

src_compile() {
	emake compile
}

src_test() {
	mkdir -p "${HOME}"/.emacs.d || die

	emake test
}

src_install() {
	elisp-install ${PN} src/${PN}/*.el{,c}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dobin extras/${PN}-console

	einstalldocs
}
