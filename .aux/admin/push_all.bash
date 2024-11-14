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

declare _remote=""

for _remote in $(git remote show) ; do
    git push "${_remote}" master
done
