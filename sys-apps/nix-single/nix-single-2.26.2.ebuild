# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit custom-cflags check-reqs edo toolchain-funcs meson

DESCRIPTION="Nix, the purely functional package manager"
HOMEPAGE="https://nixos.org/nix
	https://github.com/NixOS/nix/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/NixOS/nix"
else
	SRC_URI="https://github.com/NixOS/nix/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz"
	S="${WORKDIR}/nix-${PV}"

	# KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="
	!sys-apps/lix
	!sys-apps/nix

	app-arch/brotli:=
	app-arch/libarchive:=
	dev-cpp/nlohmann_json
	dev-cpp/toml11
	dev-db/sqlite:3=
	dev-libs/boehm-gc[cxx]
	dev-libs/boost:=
	dev-libs/editline
	dev-libs/libgit2:=
	dev-libs/libsodium:=
	dev-libs/openssl:=
	net-misc/curl
	sys-libs/libseccomp
"
DEPEND="
	${RDEPEND}
"

CHECKREQS_DISK_BUILD="2000M"

PATCHES=(
	"${FILESDIR}/nix-single-2.26.2-nix-profile.patch"
)

pkg_setup() {
	check-reqs_pkg_setup
}

src_configure() {
	custom-cflags_src_configure
	tc-export CC CXX

	local -a emesonargs=(
		-Dbindings="false"
		-Ddoc-gen="false"
		-Dunit-tests="false"
	)
	meson_src_configure
}

src_test() {
	# Disable tests.
	:
}

src_install() {
	meson_src_install

	edo mv "${D}/usr/etc" "${D}/etc"
	edo rm "${D}/usr/bin/nix-daemon"
	edo rm -r "${D}/etc/profile.d/nix-daemon."{fish,sh}
	edo rm -r "${D}/usr/lib/"{systemd,tmpfiles.d}

	local -a dirs=(
		/nix
		/nix/store
		/nix/var
		/nix/var/log
		/nix/var/log/nix
		/nix/var/log/nix/drvs
		/var/lib/nix
	)
	local dir=""
	for dir in "${dirs[@]}"; do
		keepdir "${dir}"
		fperms 1755 "${dir}"
	done
}

pkg_postinst() {
	elog 'To use for a given user do: sudo chown -R "${USER}:${USER}" "/nix" "/var/lib/nix"'
}
