# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for OCI container packages"
HOMEPAGE="https://gitlab.com/xgqt/myov/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+docker"
RESTRICT="bindist"

RDEPEND="
	app-containers/buildah
	app-containers/distrobox
	app-containers/earthly
	app-containers/k3d
	app-containers/podman
	app-containers/skopeo

	sys-cluster/k9scli
	sys-cluster/kubectl

	docker? (
		app-containers/docker
		app-containers/docker-buildx
		app-containers/docker-cli
		app-containers/docker-compose
	)
"
