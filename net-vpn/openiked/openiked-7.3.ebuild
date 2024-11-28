# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN}-portable"
MY_P="${MY_PN}-${PV}"

inherit cmake edo flag-o-matic readme.gentoo-r1 systemd

DESCRIPTION="Internet Key Exchange version 2 (IKEv2) daemon"
HOMEPAGE="https://www.openiked.org/
	https://github.com/openiked/openiked-portable/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/${PN}/${MY_PN}.git"
else
	SRC_URI="https://github.com/${PN}/${MY_PN}/archive/v${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz"
	S="${WORKDIR}/${MY_P}"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="apparmor debug"

RDEPEND="
	acct-group/_iked
	acct-user/_iked
	dev-libs/libevent:0=
	dev-libs/openssl:0=
	apparmor? (
		sys-apps/apparmor
	)
"

DOC_CONTENTS="Create a key pair if not already present:\\n
openssl ecparam -genkey -name prime256v1 -noout -out /etc/iked/private/local.key\\n
openssl ec -in /etc/iked/private/local.key -pubout -out /etc/iked/local.pub\\n\\n"

src_prepare() {
	append-cflags -mcmodel=large

	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE="$(usex debug Debug Release)"

	local -a mycmakeargs=(
		-DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}"
		-DWITH_APPARMOR="$(usex apparmor)"
	)
	cmake_src_configure
}

src_test() {
	cd "${S}_build/regress/dh"
	edob ./dhtest

	cd "${S}_build/regress/parser"
	edob ./test_parser
}

src_install() {
	cmake_src_install

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"

	keepdir /etc/iked/{ca,certs,crls,private,pubkeys} \
		/etc/iked/pubkeys/{ipv4,ipv6,fqdn,ufqdn}

	fperms 0700 /etc/iked/private
	fowners -R iked:iked /etc/iked

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
