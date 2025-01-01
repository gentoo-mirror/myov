# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for academic packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cxx +latex +python +qemu"
RESTRICT="bindist"

RDEPEND="
	app-text/doxygen[dot(+)]
	app-text/pdfgrep
	dev-vcs/git-lfs
	media-gfx/graphviz[pdf(+),python(+),svg(+)]
	virtual/jdk

	cxx? (
		dev-cpp/gtest
		dev-debug/gdb
		dev-util/ccache
		dev-util/cppcheck
	)
	latex? (
		dev-tex/latex-beamer
		dev-tex/latexmk
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-langpolish
		dev-texlive/texlive-plaingeneric
	)
	python? (
		dev-python/ipython
		dev-python/numpy
		dev-python/pip
		dev-python/scipy
	)
	qemu? (
		app-emulation/libvirt[qemu(+)]
		app-emulation/virt-manager
		app-emulation/virt-viewer
	)
"
