# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


# @ECLASS: myov-wrapper.eclass
# @MAINTAINER:
# Maciej Barć <xgqt@riseup.net>
# @AUTHOR:
# base-system@gentoo.org
# Maciej Barć <xgqt@riseup.net>
# @BLURB: create a shell wrapper script (fork of "wrapper.eclass")


case "${EAPI}"
in
	0 | 1 | 2 | 3 | 4 | 5 | 6 )
		die "EAPI: ${EAPI} too old"
		;;
	7 )
		;;
	* )
		die "EAPI: ${EAPI} not supported"
		;;
esac


_WRAPPER_ECLASS=1


# @FUNCTION: make_wrapper
# @USAGE: <wrapper> <target> [chdir] [libpaths] [installpath]
# @DESCRIPTION:
# Create a shell wrapper script named wrapper in installpath
# (defaults to the bindir) to execute target (default of wrapper)
# by first optionally setting LD_LIBRARY_PATH to the colon-delimited
# libpaths followed by optionally changing directory to chdir.

function make_wrapper() {
	local wrapper="${1}" bin="${2}"  chdir="${3}"
	local libdir="${4}"  path="${5}"

	local tmpwrapper="${T}/tmp.wrapper.${wrapper##*/}"

	has "${EAPI:-0}" 0 1 2 && local EPREFIX=""

	(
		echo "#!/bin/sh"

		cat <<EOF


# This is a wrapper created by portage on $(date '+%a %d %b %Y %T')
# for version ${PV} of the package ${CATEGORY}/${PN}


EOF

		if [ -n "${libdir}" ]; then
			local var
			if [[ "${CHOST}" == *-darwin* ]]; then
				var="DYLD_LIBRARY_PATH"
			else
				var="LD_LIBRARY_PATH"
			fi
			cat <<EOF
if [ "\${${var}+set}" = "set" ] ; then
	export ${var}="\${${var}}:${EPREFIX}${libdir}"
else
	export ${var}="${EPREFIX}${libdir}"
fi
EOF
		fi

		[ -n "${chdir}" ] && echo "cd ${EPREFIX}${chdir}"

		# We don't want to quote ${bin} so that people can pass complex
		# things as ${bin} ... "./someprog --args"
		echo "exec ${EPREFIX}${bin} \"\${@}\""

	) > "${tmpwrapper}"

	chmod go+rx "${tmpwrapper}"

	if [ -n "${path}" ]; then
		exeopts -m 0755
		exeinto "${path}"
		newexe "${tmpwrapper}" "${wrapper}"
	else
		newbin "${tmpwrapper}" "${wrapper}" || die
	fi
}
