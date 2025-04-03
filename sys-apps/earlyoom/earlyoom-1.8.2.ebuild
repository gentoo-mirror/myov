# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

DESCRIPTION="Early OOM Daemon for Linux"
HOMEPAGE="https://github.com/rfjakob/earlyoom/"

if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/rfjakob/earlyoom"
else
	SRC_URI="https://github.com/rfjakob/earlyoom/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="test"

src_compile() {
	tc-export CC

	emake \
		PREFIX="${EPREFIX}/usr" \
		VERSION="v${PV}" \
		SYSTEMDUNITDIR="$(systemd_get_systemunitdir)" \
		earlyoom earlyoom.service
}

src_install() {
	dobin earlyoom

	insinto /etc/default
	newins earlyoom.default earlyoom

	dodir /etc/conf.d
	dosym -r /etc/default/earlyoom /etc/conf.d/earlyoom

	newinitd "${FILESDIR}/${PN}-r1 ${PN}"
	systemd_dounit earlyoom.service
}
