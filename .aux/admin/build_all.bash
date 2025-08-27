#!/usr/bin/env bash

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

set -e
set -u
trap "exit 128" INT

SOURCE="${BASH_SOURCE[0]}"

while [[ -h "${SOURCE}" ]] ; do
    DIR="$(cd -P "$(dirname "${SOURCE}")" >/dev/null 2>&1 && pwd)"
    SOURCE="$(readlink "${SOURCE}")"

    [[ "${SOURCE}" != /* ]] && SOURCE="${DIR}/${SOURCE}"
done

SCRIPT_DIR="$(cd -P "$(dirname "${SOURCE}")" >/dev/null 2>&1 && pwd)"

cd "${SCRIPT_DIR}"

cd ../../

declare -a failed_ebuilds=()

ebuild=""

while read -r ebuild ; do
    if bash ./.aux/admin/build_package.bash "${ebuild}" test package clean ; then
        echo " Success, ${ebuild} has passed."
    else
        failed_ebuilds+=( "${ebuild}" )
    fi
done < \
     <(find . -type f -name "*.ebuild" -not -path "*/.cache/*" | sort)

if [[ -n "${failed_ebuilds[*]}" ]] ; then
    echo "Failed ebuilds: ${failed_ebuilds[*]}"

    exit 1
fi
