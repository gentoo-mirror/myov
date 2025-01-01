#!/bin/bash

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

if [[ "${FEATURES}" == *ccache* ]] ; then
    if [[ -z "${old_ccache_dir}" ]] ; then
        old_ccache_dir="${CCACHE_DIR}"
    fi

    if [[ "${EBUILD_PHASE_FUNC}" == src_* ]] ; then
        if [[ "${CCACHE_DIR}" == "${old_ccache_dir}" ]] ; then
            old_ccache_conf="${old_ccache_dir}/ccache.conf"
            new_ccache_dir="${old_ccache_dir}/${CATEGORY}-${PN}"
            new_ccache_conf="${new_ccache_dir}/ccache.conf"

            mkdir -p "${new_ccache_dir}" \
                || die "Failed to create new CCache directory, given: ${CCACHE_DIR}"

            if [[ -f "${old_ccache_conf}" ]] ; then
                cp "${old_ccache_conf}" "${new_ccache_conf}" \
                    || die "Failed to copy a CCache configuration file"
            fi

            if [[ "${USER}" == root || "${USER}" == portage ]] ; then
                nonfatal chown -R portage:portage "${new_ccache_dir}"
            fi

            export CCACHE_DIR="${new_ccache_dir}"
        fi
    fi
fi
