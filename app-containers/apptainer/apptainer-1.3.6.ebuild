# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic linux-info toolchain-funcs

DESCRIPTION="The container system for secure high-performance computing"
HOMEPAGE="https://apptainer.org/
	https://github.com/apptainer/apptainer/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/apptainer/${PN}.git"
else
	SRC_URI="https://github.com/apptainer/${PN}/releases/download/v${PV}/${P}.tar.gz"

	KEYWORDS="~amd64 ~riscv ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="custom-cflags debug examples +network suid systemd"

RDEPEND="
	dev-libs/openssl
	sys-libs/libseccomp

	app-crypt/gpgme
	sys-apps/util-linux
	sys-fs/cryptsetup
	sys-fs/squashfs-tools

	!suid? (
		sys-fs/e2fsprogs[fuse]
		sys-fs/squashfuse
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-lang/go
	virtual/pkgconfig
"

CONFIG_CHECK="~SQUASHFS"
QA_FLAGS_IGNORED='.*'  # Compiled by "go".

PATCHES=(
	"${FILESDIR}/apptainer-1.0.2-trim_upstream_cflags.patch"
)

DOCS=( README.md CONTRIBUTORS.md CONTRIBUTING.md )

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	local -a myconfargs=(
		-v
		-P "$(usex "debug" "debug" "release")"

		-c "$(tc-getBUILD_CC)"
		-C "$(tc-getCC)"
		-x "$(tc-getBUILD_CXX)"
		-X "$(tc-getCXX)"

		--prefix="${EPREFIX}/usr"
		--localstatedir="${EPREFIX}/var"
		--runstatedir="${EPREFIX}/run"
		--sysconfdir="${EPREFIX}/etc"

		$(usex network "" "--without-network")
		$(use_with suid)
	)
	edo bash ./mconfig "${myconfargs[@]}"
}

src_compile() {
	emake -C "${S}/builddir"
}

src_install() {
	emake -C "${S}/builddir" DESTDIR="${D}" install

	keepdir "/var/${PN}/mnt/session"

	if use systemd ; then
		sed -i \
			-e '/systemd cgroups/ s/no/yes/' \
			"${ED}/etc/${PN}/${PN}.conf" \
			|| die "Failed to enable systemd use in configuration"
	else
		sed -i \
			-e '/systemd cgroups/ s/yes/no/' \
			"${ED}/etc/${PN}/${PN}.conf" \
			|| die "Failed to disable systemd use in configuration"
	fi

	if use examples ; then
		dodoc -r examples
	fi

	einstalldocs
}
