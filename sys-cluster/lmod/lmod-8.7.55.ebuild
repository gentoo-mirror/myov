# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..3} )
PYTHON_COMPAT=( python3_{11..13} )

inherit autotools edo flag-o-matic lua-single prefix python-r1

DESCRIPTION="Environment Module System based on Lua"
HOMEPAGE="https://lmod.readthedocs.io/en/latest/
	https://github.com/TACC/Lmod/"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/TACC/Lmod"
else
	SRC_URI="https://github.com/TACC/Lmod/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/Lmod-${PV}"

	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="MIT"
SLOT="0"

IUSE="custom-cflags test"
REQUIRED_USE="${LUA_REQUIRED_USE} ${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${LUA_DEPS}
	${PYTHON_DEPS}

	dev-lang/tcl
	dev-lang/tk

	$(lua_gen_cond_dep '
		>=dev-lua/luafilesystem-1.8.0[${LUA_USEDEP}]
		dev-lua/luajson[${LUA_USEDEP}]
		dev-lua/luaposix[${LUA_USEDEP}]
		dev-lua/lua-term[${LUA_USEDEP}]
	')
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	app-alternatives/bc
	virtual/pkgconfig

	test? (
		app-shells/tcsh

		$(lua_gen_cond_dep '
			dev-util/hermes[${LUA_SINGLE_USEDEP}]
		')
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-8.4.19-no-libsandbox.patch"
)

# TODO: Retrieve from USE="savedconfig" for this?
pkg_pretend() {
	elog "You can control the siteName and syshost settings by"
	elog "using the variables LMOD_SITENAME and LMOD_SYSHOST, during"
	elog "build time, which are both set to 'Gentoo' by default."
	elog "There are a lot of options for this package, especially"
	elog "for run time behaviour. Remember to use the EXTRA_ECONF variable."
	elog "To see full list of options visit:"
	elog "\t https://lmod.readthedocs.io/en/latest/090_configuring_lmod.html"
}

src_prepare() {
	default

	# Remove bad tests.
	local -a bad_tests=(
		ck_mtree_syntax
		colorize
		csh_swap
		end2end
		help
		ifur
		ksh_to_mf
		settarg
	)
	local bad_test=""
	for bad_test in "${bad_tests[@]}" ; do
		if [[ -e "${S}/rt/${bad_test}" ]] ; then
			rm -r "${S}/rt/${bad_test}" \
				|| eerror "failed to remove test '${bad_test}'"
		else
			ewarn "Test '${bad_test}' does not exist"
		fi
	done

	# Remove vendored packages.
	rm -r pkgs/{luafilesystem,term} || die

	eautoreconf
}

src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi

	local -x LMOD_SITENAME="${LMOD_SITENAME:-Gentoo}"
	local -x LMOD_SYSHOST="${LMOD_SYSHOST:-Gentoo}"

	local LUAC="${LUA%/*}/luac${LUA#*lua}"

	local -a myconf=(
		--with-siteName="${LMOD_SITENAME}"
		--with-syshost="${LMOD_SYSHOST}"

		--with-lua_include="$(lua_get_include_dir)"
		--with-lua="${LUA}"
		--with-luac="${LUAC}"

		--prefix="${EPREFIX}/usr/share/Lmod"
		--with-module-root-path="${EPREFIX}/etc/modulefiles"
		--with-spiderCacheDir="${EPREFIX}/var/lib/lmod/spider_cache"
		--with-updateSystemFn="${EPREFIX}/var/lib/lmod/system.txt"

		--with-fastTCLInterp
		--with-supportKsh
		--with-tcl

		--without-useBuiltinPkgs

		--with-autoSwap
		--with-cachedLoads
		--with-caseIndependentSorting
		--with-colorize
		--with-exportedModuleCmd
		--with-extendedDefault
		--with-siteControlPrefix

		--without-duplicatePaths
		--without-hiddenItalic
		--without-redirect
	)
	econf "${myconf[@]}"
}

src_compile() {
	default

	# TODO: Fix "VariableScope: variable 'ED' used in 'src_compile'".
	mkdir -p "${ED}/usr/share/Lmod/lib" || die
	emake DESTDIR="${ED}" tcl2lua
}

src_test() {
	local -x PATH="${EPREFIX}/opt/hermes/bin:${PATH}"

	edo tm -vvv
	edo testcleanup
}

src_install() {
	default

	dosym -r /usr/share/Lmod/init/profile /etc/bash/bashrc.d/z00_lmod.sh
	dosym -r /usr/share/Lmod/init/profile /etc/profile.d/z00_lmod.sh
	dosym -r /usr/share/Lmod/init/cshrc /etc/profile.d/z00_lmod.csh
	dosym -r /usr/share/Lmod/init/profile.fish /etc/fish/conf.d/z00_lmod.fish

	doenvd "${FILESDIR}/99lmod"

	# not a real man page
	rm -r "${ED}/usr/share/Lmod/share/man" || die

	python_foreach_impl python_optimize "${ED}/usr/share"

	keepdir /etc/modulefiles
	keepdir /var/lib/lmod/spider_cache
}

# TODO: Update after merging?
pkg_postinst() {
	elog "Lmod spider cache has been enabled."
	elog "Remember to update the spider cache with"
	elog "/usr/share/Lmod/libexec/update_lmod_system_cache_files \ "
	elog "\t \$MODULEPATH"
}
