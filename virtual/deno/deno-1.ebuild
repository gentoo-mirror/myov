# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for deno"

SLOT="${PV}"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	|| (
		dev-lang/deno-bin:0/${PV}
		dev-lang/deno:0/${PV}
	)
"