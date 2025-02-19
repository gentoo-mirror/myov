# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN^}-${PV/_/-}"

PYTHON_COMPAT=( python3_{11..13} )

inherit autotools custom-cflags python-single-r1

DESCRIPTION="Pacemaker CRM"
HOMEPAGE="https://www.clusterlabs.org/pacemaker/
	https://github.com/ClusterLabs/pacemaker/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/ClusterLabs/${PN}.git"
else
	SRC_URI="https://github.com/ClusterLabs/${PN}/archive/${MY_P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_P}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+ LGPL-2.1+ BSD CC-BY-SA-4.0"
SLOT="0"
IUSE="acl smtp snmp"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}

	>=sys-cluster/cluster-glue-1.0.12-r1
	>=sys-cluster/libqb-2.0.0:=
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-cluster/corosync
	sys-cluster/resource-agents

	smtp? ( net-libs/libesmtp )
	snmp? ( net-analyzer/net-snmp )
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	sed -i -e "s/ -ggdb//g" ./configure.ac || die

	default

	eautoreconf
}

src_configure() {
	custom-cflags_src_configure

	local -a myconf=(
		--disable-fatal-warnings
		--disable-static

		# appends lib to localstatedir automatically
		--with-ocfdir="/usr/$(get_libdir)/ocf"
		--localstatedir="/var"

		--without-cs-quorum
		--without-cman
		--without-heartbeat
		--with-corosync
		--with-ais

		$(use_with acl)
		$(use_with smtp esmtp)
		$(use_with snmp)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	python_optimize "${ED}/usr"

	# remove provided initd file as we need support for OpenRC
	rm -rf "${ED}/etc/init.d" || die
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"

	keepdir /var/lib/pacemaker/{blackbox,cib,cores,pengine}
	keepdir /var/log/pacemaker/bundles

	find "${ED}" -name '*.la' -delete || die
}
