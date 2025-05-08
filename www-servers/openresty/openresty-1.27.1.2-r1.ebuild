# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit custom-cflags edo multiprocessing systemd toolchain-funcs

DESCRIPTION="High Performance Web Platform Based on Nginx and LuaJIT"
HOMEPAGE="https://openresty.org/
	https://github.com/openresty/openresty/"
SRC_URI="https://openresty.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="pcre threads"
RESTRICT="test"  # No (auto-wired) tests in the bundle.

RDEPEND="
	dev-libs/libatomic_ops
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/openssl:=
	media-libs/gd:=[webp]
	sys-libs/zlib:=
	virtual/libcrypt:=

	pcre? (
		dev-libs/libpcre2:=
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-lang/perl
"

# Lua libs
QA_PREBUILT="usr/lib64/openresty/lualib/.*"

src_configure() {
	custom-cflags_src_configure
	tc-export AR AS CC CPP CXX LD NM PKG_CONFIG RANLIB STRIP

	local -a myconf=(
		-j"$(makeopts_jobs)"
		--build="${P}-compilation"

		--with-cc="$(tc-getCC)"
		--with-cpp="$(tc-getCPP)"
		--with-cc-opt="${CFLAGS} -Wall -Wextra"
		--with-ld-opt="${LDFLAGS}"

		--prefix="${EPREFIX}/usr/$(get_libdir)/${PN}"
		--modules-path="${EPREFIX}/usr/share/${PN}/modules"
		--sbin-path="${EPREFIX}/usr/sbin/${PN}"
		--conf-path="${EPREFIX}/etc/${PN}/conf/nginx.conf"
		--error-log-path="${EPREFIX}/var/log/${PN}/error.log"
		--lock-path="${EPREFIX}/run/${PN}/${PN}.lock"
		--pid-path="${EPREFIX}/run/${PN}/${PN}.pid"

		# Features
		$(use_with pcre pcre)
		$(use_with pcre pcre-jit)
		$(use_with threads)
		--with-compat
		--with-file-aio
		--with-libatomic
		--with-mail
		--with-stream

		# Modules - http
		--with-http_addition_module
		--with-http_auth_request_module
		--with-http_dav_module
		--with-http_degradation_module
		--with-http_flv_module
		--with-http_gunzip_module
		--with-http_gzip_static_module
		--with-http_image_filter_module
		--with-http_mp4_module
		--with-http_random_index_module
		--with-http_realip_module
		--with-http_secure_link_module
		--with-http_slice_module
		--with-http_ssl_module
		--with-http_stub_status_module
		--with-http_sub_module
		--with-http_v2_module
		--with-http_v3_module
		--with-http_xslt_module

		# Modules - stream
		--with-stream_realip_module
		--with-stream_ssl_module
		--with-stream_ssl_preread_module

		# Modules - mail
		--with-mail_ssl_module
	)
	edo perl ./configure "${myconf[@]}"
}

src_install() {
	default

	systemd_newunit "${FILESDIR}/nginx.service" nginx.service

	rm -r "${ED}/run" || die
	keepdir /var/log/openresty
}
