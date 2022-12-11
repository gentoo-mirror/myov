# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for basic system packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+archive +crypt emacs +gentoo grub +hardware +network"
RESTRICT="bindist"

RDEPEND="
	app-admin/rsyslog
	app-admin/sysstat
	app-misc/tmux
	app-shells/bash-completion[eselect(+)]
	app-shells/zsh[unicode(+)]
	app-text/tree
	dev-util/strace
	dev-util/trace-cmd
	dev-vcs/git[gpg(+)]
	sys-apps/busybox
	sys-block/parted
	sys-devel/gdb
	sys-fs/dfc
	sys-fs/dosfstools
	sys-fs/mdadm
	sys-process/audit
	sys-process/cronie
	sys-process/htop
	sys-process/lsof
	archive? (
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
		app-arch/xz-utils
		app-arch/zip
	)
	crypt? (
		sys-fs/cryptsetup
		sys-fs/lvm2
		grub? ( sys-boot/grub[device-mapper(+)] )
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
		app-portage/gentoolkit
		app-portage/portage-utils
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
	grub? ( sys-boot/grub[mount(+)] )
	hardware? (
		sys-apps/hwloc
		sys-apps/i2c-tools
		sys-apps/lm-sensors
		sys-apps/lshw
		sys-apps/pciutils
		sys-apps/smartmontools
		sys-apps/usbutils
		sys-fs/sysfsutils
		sys-kernel/linux-firmware
		sys-power/powertop
		sys-process/htop[lm-sensors(+)]
		network? ( sys-apps/ethtool )
	)
	network? (
		net-analyzer/arp-scan
		net-analyzer/iftop
		net-analyzer/iptraf-ng
		net-analyzer/mtr
		net-analyzer/nethogs
		net-analyzer/nmap
		net-analyzer/openbsd-netcat
		net-analyzer/tcpdump
		net-analyzer/tcptraceroute
		net-analyzer/traceroute
		net-dns/bind-tools
		net-fs/nfs-utils
		net-fs/sshfs
		net-ftp/lftp
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
