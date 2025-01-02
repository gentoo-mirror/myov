# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for basic system packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+archive +crypt emacs +fonts +gentoo grub +hardware +network prefix"
RESTRICT="bindist"

# "NO_PREFIX_DEPEND" contains packages that do not work or make no sense on
# the Gentoo EPrefix, so ones available only for your standard Gentoo systems.
NO_PREFIX_DEPEND="
	app-admin/logrotate
	app-admin/rsyslog
	app-admin/sudo
	app-admin/sysstat
	sys-fs/mdadm
	sys-process/audit
	sys-process/cronie

	crypt? (
		sys-fs/cryptsetup
		sys-fs/lvm2

		grub? (
			sys-boot/grub[device-mapper(+)]
		)
	)
	fonts? (
		media-fonts/terminus-font
	)
	grub? (
		sys-boot/grub[mount(+)]
	)
	network? (
		net-fs/nfs-utils
	)
"

RDEPEND="
	app-editors/vim
	app-misc/tmux
	app-shells/bash-completion[eselect(+)]
	app-shells/loksh
	app-shells/tcsh
	app-shells/zsh[unicode(+)]
	app-text/htmltidy
	app-text/tree
	dev-debug/gdb
	dev-debug/strace
	dev-util/trace-cmd
	dev-vcs/git[gpg(+)]
	sys-apps/busybox
	sys-apps/moreutils
	sys-block/parted
	sys-fs/dfc
	sys-fs/dosfstools
	sys-libs/cracklib
	sys-process/htop
	sys-process/lsof

	!prefix? (
		${NO_PREFIX_DEPEND}
	)

	archive? (
		app-arch/xar
		app-arch/bzip2
		app-arch/dpkg
		app-arch/gzip
		app-arch/libarchive
		app-arch/lz4
		app-arch/p7zip
		app-arch/rpm
		app-arch/tar
		app-arch/unrar
		app-arch/unzip
		app-arch/zip
	)
	emacs? (
		app-admin/emacs-updater
		app-editors/emacs

		gentoo? (
			app-emacs/ebuild-mode
			app-emacs/nxml-gentoo-schemas
		)
	)
	gentoo? (
		app-doc/eclass-manpages
		app-eselect/eselect-package-manager
		app-eselect/eselect-repository
		app-eselect/eselect-timezone
		app-eselect/eselect-vi
		app-portage/eix
		app-portage/elogv
		app-portage/elsw
		app-portage/gentoolkit
		app-portage/portage-utils
		app-portage/pram
		app-portage/smart-live-rebuild
		dev-util/pkgcheck
		dev-util/pkgdev
		sys-devel/crossdev

		hardware? (
			app-portage/cpuid2cpuflags
			app-admin/eclean-kernel
			sys-kernel/genkernel
		)
	)
	hardware? (
		sys-apps/hwloc
		sys-apps/i2c-tools
		sys-apps/lm-sensors
		sys-apps/lshw
		sys-apps/pciutils
		sys-apps/smartmontools
		sys-apps/usbutils
		sys-fs/exfatprogs
		sys-fs/sysfsutils
		sys-kernel/linux-firmware
		sys-power/powertop
		sys-process/htop[lm-sensors(+)]

		network? (
			sys-apps/ethtool
		)
	)
	network? (
		net-analyzer/arp-scan
		net-analyzer/ifstat
		net-analyzer/iftop
		net-analyzer/iptraf-ng
		net-analyzer/mtr
		net-analyzer/nethogs
		net-analyzer/nmap
		net-analyzer/openbsd-netcat
		net-analyzer/tcpdump
		net-analyzer/tcptraceroute
		net-analyzer/traceroute
		net-dns/bind
		net-fs/sshfs
		net-misc/curl
		net-misc/iperf
		net-misc/iputils
		net-misc/mosh
		net-misc/ntp
		net-misc/socat
		net-misc/whois
	)
"

pkg_postinst() {
	if use gentoo ; then
		# Do not fail here

		ebegin "Setting default package manger"
		eselect package-manager update
		eend 0

		ebegin "Setting default Vi implementation"
		eselect vi update
		eend 0
	fi
}
