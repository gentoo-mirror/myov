# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CCache Portage hook"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
S="${WORKDIR}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
RESTRICT="bindist"

src_unpack() {
	:
}

src_install() {
	insinto /etc/portage/bashrc.d
	doins "${FILESDIR}/0000_ccache_hook_${PV}.bash"
}
