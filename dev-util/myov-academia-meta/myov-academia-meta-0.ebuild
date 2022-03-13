# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for academic packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cxx +latex +python +qemu"

RDEPEND="
	app-doc/doxygen[dot(+)]
	app-text/pdfgrep
	dev-java/openjdk
	dev-vcs/git
	dev-vcs/git-lfs
	media-gfx/graphviz[pdf(+),python(+),svg(+)]
	net-analyzer/wireshark[qt5(+)]
	|| (
		app-office/libreoffice[pdfimport(+)]
		app-office/libreoffice-bin
	)
	|| ( app-text/pandoc app-text/pandoc-bin )
	|| ( dev-util/shellcheck dev-util/shellcheck-bin )
	cxx? (
		dev-cpp/gtest
		dev-util/ccache
		sys-devel/gdb
	)
	latex? (
		app-office/texstudio
		app-text/kbibtex
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-plaingeneric
		dev-texlive/texlive-xetex
	)
	python? (
		dev-python/black
		dev-python/jupyter
		dev-python/nose
		dev-python/numpy
		dev-python/pandas
		dev-python/pip
		dev-python/pylint
		dev-python/pytest
		dev-python/responses
		dev-python/scipy
		dev-python/sphinx
		dev-python/virtualenv
	)
	qemu? (
		app-emulation/libvirt
		app-emulation/virt-manager
		app-emulation/virt-viewer
	)
"