# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Emacs Lisp packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gentoo +git gui ocaml +package-developer"
RESTRICT="bindist"

RDEPEND="
	app-admin/emacs-updater

	app-emacs/amx
	app-emacs/apheleia
	app-emacs/counsel
	app-emacs/dashboard
	app-emacs/demap
	app-emacs/diminish
	app-emacs/editorconfig-emacs
	app-emacs/flycheck
	app-emacs/highlight-indentation
	app-emacs/ivy-rich
	app-emacs/lsp-mode
	app-emacs/org-appear
	app-emacs/rainbow-delimiters
	app-emacs/spacemacs-theme
	app-emacs/swiper
	app-emacs/switch-window
	app-emacs/undo-tree
	app-emacs/use-package
	app-emacs/webpaste
	app-emacs/which-key
	app-emacs/yasnippet
	app-emacs/yasnippet-snippets

	app-emacs/apache-mode
	app-emacs/dockerfile-mode
	app-emacs/markdown-mode
	app-emacs/meson-mode
	app-emacs/nginx-mode
	app-emacs/systemd-mode
	app-emacs/yaml-mode

	|| (
		app-text/aspell
		app-text/hunspell
	)

	gentoo? (
		app-emacs/company-ebuild
		app-emacs/ebuild-mode
		app-emacs/emacs-ebuild-snippets
		app-emacs/nxml-gentoo-schemas
		dev-util/pkgcheck[emacs]
	)
	git? (
		app-emacs/diff-hl
		app-emacs/git-modes
		app-emacs/magit
		app-emacs/projectile
	)
	gui? (
		app-editors/emacs[gui(+)]
		app-emacs/all-the-icons-dired
		app-emacs/all-the-icons-ibuffer
		app-emacs/all-the-icons-ivy-rich
		app-emacs/emojify
	)
	ocaml? (
		>=dev-lang/ocaml-4.07.0
		app-emacs/dune-format
		app-emacs/tuareg-mode
		dev-ml/merlin[emacs(+)]
	)
	package-developer? (
		app-emacs/assess
		app-emacs/buttercup
		app-emacs/eldev
		app-emacs/ert-runner
		app-emacs/flycheck-package
		app-emacs/mocker
		app-emacs/noflet
		app-emacs/package-lint
		app-emacs/undercover
		app-emacs/with-simulated-input
	)
"
