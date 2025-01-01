# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for net-vpn/openiked VPN"

ACCT_USER_GROUPS=( _iked )

acct-user_add_deps
