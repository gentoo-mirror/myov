# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Emacs Lisp packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+git gui +java +python"
RESTRICT="bindist"

RDEPEND="
	app-emacs/amx
	app-emacs/buttercup
	app-emacs/company-math
	app-emacs/counsel
	app-emacs/csharp-mode
	app-emacs/dashboard
	app-emacs/deft
	app-emacs/diminish
	app-emacs/dockerfile-mode
	app-emacs/editorconfig-emacs
	app-emacs/elpher
	app-emacs/ert-runner
	app-emacs/flycheck-guile
	app-emacs/flycheck-package
	app-emacs/fsharp-mode
	app-emacs/geiser-chez
	app-emacs/geiser-guile
	app-emacs/go-mode
	app-emacs/haskell-mode
	app-emacs/haxe-mode
	app-emacs/highlight-indentation
	app-emacs/ivy-rich
	app-emacs/julia-mode
	app-emacs/lsp-mode
	app-emacs/lua-mode
	app-emacs/markdown-mode
	app-emacs/meson-mode
	app-emacs/org-appear
	app-emacs/org-superstar-mode
	app-emacs/package-lint
	app-emacs/rainbow-delimiters
	app-emacs/rainbow-mode
	app-emacs/rust-mode
	app-emacs/spacemacs-theme
	app-emacs/swiper
	app-emacs/switch-window
	app-emacs/typescript-mode
	app-emacs/undo-tree
	app-emacs/use-package
	app-emacs/webpaste
	app-emacs/which-key
	app-emacs/yaml-mode
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
	java? (
		>=virtual/jdk-11
		app-emacs/lsp-java
	)
	python? ( app-emacs/elpy )
"
