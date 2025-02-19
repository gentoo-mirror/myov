# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

case "${EAPI}" in
    7 | 8 ) : ;;
    * ) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_CUSTOM_CFLAGS} ]] ; then
_CUSTOM_CFLAGS=1

inherit flag-o-matic

IUSE+=" custom-cflags "

custom-cflags_src_configure() {
	if use custom-cflags ; then
		:
	else
		strip-flags
	fi
}
fi

EXPORT_FUNCTIONS src_configure
