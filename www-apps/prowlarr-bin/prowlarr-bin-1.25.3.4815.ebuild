# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd edo

DESCRIPTION="An indexer manager/proxy to integrate with your various PVR apps"
HOMEPAGE="https://prowlarr.com/
	https://wiki.servarr.com/prowlarr/"

BASE_URI="https://github.com/Prowlarr/Prowlarr/releases/download/v${PV}"
SRC_URI="
amd64? (
	elibc_glibc? (
		${BASE_URI}/Prowlarr.develop.${PV}.linux-core-x64.tar.gz
	)
	elibc_musl? (
		${BASE_URI}/Prowlarr.develop.${PV}.linux-musl-core-x64.tar.gz
	)
)
arm? (
	elibc_glibc? (
		${BASE_URI}/Prowlarr.develop.${PV}.linux-core-arm.tar.gz
	)
	elibc_musl? (
		${BASE_URI}/Prowlarr.develop.${PV}.linux-musl-core-arm.tar.gz
	)
)
arm64? (
	elibc_glibc? (
		${BASE_URI}/Prowlarr.develop.${PV}.linux-core-arm64.tar.gz
	)
	elibc_musl? (
		${BASE_URI}/Prowlarr.develop.${PV}.linux-musl-core-arm64.tar.gz
	)
)
"
S="${WORKDIR}/Prowlarr"

LICENSE="GPL-3+"
SLOT="0/${PV}"
KEYWORDS="-* ~amd64 ~arm ~arm64"
RESTRICT="strip test"

RDEPEND="
	acct-group/prowlarr
	acct-user/prowlarr
	dev-db/sqlite:3
	dev-libs/icu
"

QA_PREBUILT="*"

src_prepare() {
	default

	# https://github.com/dotnet/runtime/issues/57784
	rm {.,Prowlarr.Update}/libcoreclrtraceptprovider.so || die
}

src_install() {
	dodir /opt/prowlarr
	edo cp -r "${S}/." "${D}/opt/prowlarr"

	cd "${D}" || die
	edo find . -type f -name "*.so" -exec chmod a+rx {} +

	newinitd "${FILESDIR}/prowlarr.init" prowlarr
	systemd_dounit "${FILESDIR}/prowlarr.service"
	systemd_newunit "${FILESDIR}/prowlarr.service" "prowlarr@.service"

	insinto /etc/logrotate.d
	insopts -m0644
	newins "${FILESDIR}/prowlarr.logrotate" prowlarr

	keepdir /var/lib/prowlarr
	fowners -r prowlarr:prowlarr /var/lib/prowlarr
}
