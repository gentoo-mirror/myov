#!/bin/bash

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

if [[ "${FEATURES}" == *ccache* ]] ; then
    if [[ -z "${old_ccache_dir}" ]] ; then
        _old_ccache_dir="${CCACHE_DIR}"
    fi

    if [[ "${CCACHE_DIR}" == "${_old_ccache_dir}" ]] ; then
        _old_ccache_conf="${_old_ccache_dir}/ccache.conf"
        _new_ccache_dir="${_old_ccache_dir}/${CATEGORY}-${PN}"
        _new_ccache_conf="${_new_ccache_dir}/ccache.conf"

        case "${EBUILD_PHASE_FUNC}" in
            pkg_setup | pkg_postinst )
                if [[ ! -d "${_new_ccache_dir}" ]] ; then
                    einfo "Creating new CCache directory: ${_new_ccache_dir}"

                    mkdir -p "${_new_ccache_dir}" \
                        || die "Failed to create new CCache directory, given: ${CCACHE_DIR}"
                fi

                if [[ -f "${_old_ccache_conf}" ]] ; then
                    cp "${_old_ccache_conf}" "${_new_ccache_conf}" \
                        || die "Failed to copy a CCache configuration file"
                else
                    ewarn "Old original CCache config file not found, given: ${_old_ccache_conf}"
                fi

                nonfatal chown -R portage:portage "${_new_ccache_dir}"
                nonfatal chmod -R u+rw "${_new_ccache_dir}"
                nonfatal chmod -R g+rw "${_new_ccache_dir}"
                ;;
            * )
                :
                ;;
        esac

        export CCACHE_DIR="${_new_ccache_dir}"
    fi
fi
