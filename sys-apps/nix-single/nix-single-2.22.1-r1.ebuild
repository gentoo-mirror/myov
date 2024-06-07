# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="Nix, the purely functional package manager"
HOMEPAGE="https://nixos.org/nix
	https://github.com/NixOS/nix/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/NixOS/nix.git"
else
	SRC_URI="https://github.com/NixOS/nix/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz"
	S="${WORKDIR}/nix-${PV}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="
	!sys-apps/nix
"
BDEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}/${PN}-2.22.1-lib-paths.patch"
	"${FILESDIR}/${PN}-2.22.1-nix-profile.patch"
)

src_prepare() {
	default
	eautoreconf

	# HACK: Workaround unhandled AC_CONFIG_AUX_DIR in autotools.eclass.
	# See: https://bugs.gentoo.org/927017
	mkdir -p ./config/ || die
	cp config.guess config.sub ./config/ || die
}

src_configure() {
	export V="1"
	local -x CONFIG_SHELL="${BROOT}/bin/bash"
	tc-export CC CXX

	local -a conf_opts=(
		--localstatedir="/nix/var"
		--sharedstatedir="/nix/var"

		--enable-largefile
		--with-readline-flavor="readline"

		# FIXME: Patch to re-enable.
		--disable-gc

		--disable-cpuid
		--disable-markdown

		# Disable docs
		--disable-doc-gen
		--disable-external-api-docs
		--disable-internal-api-docs

		# Disable tests
		--disable-install-unit-tests
		--disable-unit-tests
	)
	econf "${conf_opts[@]}"
}

src_test() {
	# Disable tests.
	:
}

src_install() {
	default

	rm "${D}/usr/bin/nix-daemon" || die
	rm -r "${D}/etc/"{init,profile.d/nix-daemon.{fish,sh}} || die
	rm -r "${D}/usr/"{include,lib64/pkgconfig} || die
	rm -r "${D}/usr/lib/"{systemd,tmpfiles.d} || die

	keepdir /nix/com /nix/com/nix /nix/store /nix/var
	fperms 1775 /nix/com /nix/com/nix /nix/store /nix/var
}

pkg_postinst() {
	elog "To use for a given user do: chown -R USER:USER /nix"
}
