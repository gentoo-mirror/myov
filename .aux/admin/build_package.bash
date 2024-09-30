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

declare -r cache="$(pwd)/.cache"
declare -r build_log_file="${cache}/build.log"

mkdir -p "${cache}"
rm -f "${build_log_file}"

export FEATURES="test"
export USE="test"
export ACCEPT_LICENSE="*"

export PORTAGE_ELOG_CLASSES="warn error log"
export PORTAGE_ELOG_SYSTEM="echo save"

export DISTDIR="${cache}/distdiles"
export PKGDIR="${cache}/binpkgs"
export PORTAGE_LOGDIR="${cache}/log"
export PORTAGE_TMPDIR="${cache}/tmp"

mkdir -p "${DISTDIR}"
mkdir -p "${PKGDIR}"
mkdir -p "${PORTAGE_LOGDIR}"
mkdir -p "${PORTAGE_TMPDIR}"

echo ">>> Working on ebuild: ${1}"

set -x

ebuild "${1}" clean
ebuild "${1}" compile
ebuild "${1}" test
ebuild "${1}" package
ebuild "${1}" clean
