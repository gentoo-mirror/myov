# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Shell completion for Bazel"
HOMEPAGE="https://bazel.build/
	https://github.com/bazelbuild/bazel/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/bazelbuild/bazel.git"
else
	SRC_URI="https://github.com/bazelbuild/bazel/archive/${PV}.tar.gz
		-> ${P}.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi

S="${WORKDIR}/bazel-${PV}/scripts/zsh_completion"

LICENSE="Apache-2.0"
SLOT="0"

src_install() {
	insinto /usr/share/zsh/site-functions
	doins _bazel
}