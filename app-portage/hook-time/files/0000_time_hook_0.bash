#!/bin/bash

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

time_hook_calculate_age() {
    local diff=$(( "${1}" - "${2}" ))
    local s=$(( "${diff}" % 60 ))
    local m=$(( ( "${diff}" / 60 ) % 60 ))
    local h=$(( "${diff}" / 3600 ))

    echo "${h}h ${m}m ${s}s"
}

time_hook_phase_took() {
    echo " [$(date '+%H:%M:%S') DEBUG   ] Run of phase ${1^^} took $(time_hook_calculate_age "${2}" "${3}")"
}

time_hook_main () {
    local h_dir="${PORTAGE_BUILDDIR}/hooks"
    local t_dir="${h_dir}/time"

    mkdir -p "${t_dir}" || die

    local phase_file="${t_dir}/phase.txt"
    local epoch_file="${t_dir}/epoch.txt"

    local curr_epoch ; curr_epoch="$(date +%s)"
    local last_epoch
    last_epoch="$(cat "${epoch_file}" 2>/dev/null || echo "")"

    local curr_phase ; curr_phase="${EBUILD_PHASE}"
    local last_phase
    last_phase="$(cat "${phase_file}" 2>/dev/null || echo "")"

    if [[ -n "${last_phase}" ]] && [[ "${curr_phase}" != "${last_phase}" ]] ;
    then
        if [[ "${curr_phase}" != clean ]] ; then
            time_hook_phase_took "${last_phase}" "${curr_epoch}" "${last_epoch}"
        fi
        echo "${curr_epoch}" > "${epoch_file}" || die
        echo "${curr_phase}" > "${phase_file}" || die
    fi

    if [[ ! -f "${epoch_file}" ]] ; then
        echo "${curr_epoch}" > "${epoch_file}" || die
        chmod g=rw             "${epoch_file}" || die
        chown :portage         "${epoch_file}" || die
    fi
    if [[ ! -f "${phase_file}" ]] ; then
        echo "${curr_phase}" > "${phase_file}" || die
        chmod g=rw             "${phase_file}" || die
        chown :portage         "${phase_file}" || die
    fi

    case "${curr_phase}" in
        clean | cleanrm )
            rm -r "${t_dir}" 2>/dev/null
            rm -d "${h_dir}" 2>/dev/null  # clean if empty
            ;;
        * )
            :
            ;;
    esac
}

if [[ -n "${EBUILD_PHASE}" ]] && [[ "${EBUILD_PHASE}" != depend ]] ; then
    time_hook_main
fi
