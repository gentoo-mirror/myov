# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for academic packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="android +cxx emacs +latex +python +qemu"
REQUIRED_USE="android? ( qemu )"
RESTRICT="bindist"

RDEPEND="
	app-doc/doxygen[dot(+)]
	app-text/pdfgrep
	dev-vcs/git
	dev-vcs/git-lfs
	media-gfx/graphviz[pdf(+),python(+),svg(+)]
	virtual/jdk
	virtual/pandoc
	|| ( app-office/libreoffice-bin app-office/libreoffice[pdfimport(+)] )
	|| ( dev-util/shellcheck-bin dev-util/shellcheck )
	android? (
		dev-util/android-studio
		dev-util/android-tools
	)
	cxx? (
		dev-cpp/gtest
		dev-util/ccache
		dev-util/cppcheck
		sys-devel/gdb
	)
	emacs? (
		app-emacs/myov-emacs-meta[git(+)]
		latex? (
			app-emacs/auctex
			app-emacs/biblio
			app-emacs/ebib
		)
	)
	latex? (
		dev-tex/latex-beamer
		dev-tex/latexmk
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-langpolish
		dev-texlive/texlive-plaingeneric
		dev-texlive/texlive-xetex
	)
	python? (
		dev-python/autopep8
		dev-python/black
		dev-python/coverage
		dev-python/jupyter
		dev-python/numpy
		dev-python/pandas
		dev-python/pip
		dev-python/pylint
		dev-python/pytest
		dev-python/responses
		dev-python/scipy
		dev-python/sphinx
		dev-python/tox
		dev-python/twine
		dev-python/virtualenv
	)
	qemu? (
		app-emulation/libvirt[qemu(+)]
		app-emulation/virt-manager
		app-emulation/virt-viewer
	)
"
