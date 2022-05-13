# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Emacs Lisp packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+git gui +guile +java +package-developer +polyglot +python"
RESTRICT="bindist"

RDEPEND="
	app-emacs/amx
	app-emacs/company-math
	app-emacs/counsel
	app-emacs/dashboard
	app-emacs/deft
	app-emacs/diminish
	app-emacs/editorconfig-emacs
	app-emacs/elpher
	app-emacs/highlight-indentation
	app-emacs/ivy-rich
	app-emacs/org-appear
	app-emacs/org-superstar-mode
	app-emacs/rainbow-delimiters
	app-emacs/rainbow-mode
	app-emacs/spacemacs-theme
	app-emacs/swiper
	app-emacs/switch-window
	app-emacs/undo-tree
	app-emacs/use-package
	app-emacs/webpaste
	app-emacs/which-key
	app-emacs/yasnippet
	app-emacs/yasnippet-snippets
	git? (
		app-emacs/diff-hl
		app-emacs/magit
		app-emacs/projectile
		dev-vcs/git
	)
	gui? (
		app-editors/emacs[gui(+)]
		app-emacs/all-the-icons-dired
		app-emacs/all-the-icons-ibuffer
		app-emacs/all-the-icons-ivy-rich
		app-emacs/company-quickhelp
		app-emacs/emojify
	)
	guile? (
		app-emacs/flycheck-guile
		app-emacs/geiser-guile
	)
	java? (
		>=virtual/jdk-11
		app-emacs/lsp-java
	)
	package-developer? (
		app-emacs/buttercup
		app-emacs/cask
		app-emacs/eldev
		app-emacs/ert-runner
		app-emacs/flycheck-package
		app-emacs/mocker
		app-emacs/package-lint
	)
	polyglot? (
		app-emacs/csharp-mode
		app-emacs/dockerfile-mode
		app-emacs/fsharp-mode
		app-emacs/geiser-chez
		app-emacs/go-mode
		app-emacs/haskell-mode
		app-emacs/haxe-mode
		app-emacs/julia-mode
		app-emacs/lsp-mode
		app-emacs/lua-mode
		app-emacs/markdown-mode
		app-emacs/meson-mode
		app-emacs/rust-mode
		app-emacs/typescript-mode
		app-emacs/yaml-mode
	)
	python? (
		app-emacs/elpy
		app-emacs/emacs-ipython-notebook
		dev-python/ipython
	)
"
