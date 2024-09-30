#!/usr/bin/env bash

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

ebuild=""

while read -r ebuild ; do
    bash ./.aux/admin/build_package.bash "${ebuild}"
done < \
     <(find . -type f -name "*.ebuild" -not -path "*/.cache/*" | sort)
