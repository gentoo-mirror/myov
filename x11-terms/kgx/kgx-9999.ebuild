# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit git-r3 meson gnome2-utils xdg-utils

DESCRIPTION="A minimal terminal for GNOME"
HOMEPAGE="https://gitlab.gnome.org/ZanderBrown/kgx"
EGIT_REPO_URI="https://gitlab.gnome.org/ZanderBrown/kgx"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    ${PYTHON_DEPS}
    dev-libs/appstream-glib[introspection]
    dev-util/desktop-file-utils
    dev-util/meson
    x11-libs/gtk+:3
    >=x11-libs/vte-0.54.4
    gnome-base/gsettings-desktop-schemas
    gnome-base/libgtop
    >=dev-libs/glib-2.58.0
    >=dev-libs/libpcre2-10.32
"

RDEPEND="
    ${DEPEND}
"

pkg_preinst() {
    gnome2_schemas_savelist
}

pkg_postinst() {
    gnome2_gconf_install
    gnome2_schemas_update
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    gnome2_gconf_uninstall
    gnome2_schemas_update
    xdg_desktop_database_update
    xdg_icon_cache_update
}
