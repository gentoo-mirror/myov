# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS=24.1

inherit elisp

DESCRIPTION="Run a Emacs batch process REPL inside Emacs"
HOMEPAGE="https://gitlab.com/xgqt/emacs-eie/"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/xgqt/${PN}.git"
else
	SRC_URI="https://gitlab.com/xgqt/${PN}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"

SITEFILE="50${PN}-gentoo.el"
