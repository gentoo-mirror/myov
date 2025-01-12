# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for server/workstation with a feeling of a mainframe"
HOMEPAGE="https://gitlab.com/xgqt/myov/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui +postgres"
RESTRICT="bindist"

RDEPEND="
	app-antivirus/clamav
	app-backup/restic
	app-containers/incus
	app-misc/mc
	app-misc/uptimed

	dev-lang/bas
	dev-lang/quickjs

	dev-lang/php[apache2]
	dev-util/0xtools
	dev-util/perf

	net-analyzer/zabbix[agent2,postgres,server]
	net-firewall/firewalld[gui?]
	net-misc/rclone

	www-apps/phpsysinfo

	|| (
		dev-lang/oorexx
		dev-lang/regina-rexx
	)

	gui? (
		app-antivirus/clamtk
	)
	postgres? (
		dev-db/pg_top
		dev-db/phppgadmin
	)
"
