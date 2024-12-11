# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for server/workstation with a feeling of a mainframe"
HOMEPAGE="https://gitlab.com/xgqt/myov/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui"
RESTRICT="bindist"

RDEPEND="
	app-antivirus/clamav
	dev-lang/php[apache2]
	net-analyzer/zabbix[agent2,postgres,server]
	net-firewall/firewalld[gui?]

	dev-db/pg_top
	dev-db/phppgadmin

	dev-lang/bas
	dev-lang/quickjs

	www-apps/phpsysinfo
	www-misc/monitorix

	|| (
		dev-lang/oorexx
		dev-lang/regina-rexx
	)

	gui? (
		app-antivirus/clamtk
	)
"
