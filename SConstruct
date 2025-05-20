# Copyright (c) 2024-2025, Maciej Barć <xgqt@xgqt.org>

# Documentation: https://scons.org/doc/production/HTML/scons-man.html


import os

from shutil import which

from SCons.Script import Clean
from SCons.Script import Default
from SCons.Script import Dir
from SCons.Script import Environment
from SCons.Script import Variables


tools = [
    "default",
]

opts = Variables()

# Egencache
opts.Add(
    key="EGENCACHE",
    help="path to the egencache command binary",
    default=which(cmd="egencache") or "egencache",
)
opts.Add(
    key="EGENCACHE_DEFAULT_OPTS",
    help="egencache lint options",
    default="--verbose --update",
)
opts.Add(
    key="EGENCACHE_EXTRA_OPTS",
    help="extra egencache lint options",
    default="",
)

# Pkgdev
opts.Add(
    key="PKGDEV",
    help="path to the pkgdev command binary",
    default=which(cmd="pkgdev") or "pkgdev",
)
opts.Add(
    key="PKGDEV_DEFAULT_OPTS",
    help="pkgdev lint options",
    default="--verbose",
)
opts.Add(
    key="PKGDEV_EXTRA_OPTS",
    help="extra pkgdev lint options",
    default="",
)

# Pkgcheck
opts.Add(
    key="PKGCHECK",
    help="path to the pkgcheck command binary",
    default=which(cmd="pkgcheck") or "pkgcheck",
)
opts.Add(
    key="PKGCHECK_CONFIG",
    help="path to the pkgcheck configuration file",
    default="${PWD}/metadata/pkgcheck.conf",
)
opts.Add(
    key="PKGCHECK_DEFAULT_OPTS",
    help="pkgcheck lint options",
    default="--config ${PKGCHECK_CONFIG} --verbose",
)
opts.Add(
    key="PKGCHECK_EXTRA_OPTS",
    help="extra pkgcheck lint options",
    default="",
)


orig_env = os.environ.copy()

env = Environment(
    ENV=orig_env,
    variables=opts,
    tools=tools,
)


source_root = Dir(".")
env["PWD"] = source_root.srcnode().abspath

cache = source_root.Dir(".cache")
env["CACHE"] = cache.srcnode().abspath

aux = source_root.Dir(".aux")
env["AUX"] = aux.srcnode().abspath

admin = aux.Dir("admin")
env["ADMIN"] = admin.srcnode().abspath


build_all = env.Command(
    target=["build-all"],
    source=[admin.File("build_all.bash")],
    action=["bash ${SOURCE}"],
)
env.AlwaysBuild(build_all)

pkgdev_manifests = env.Command(
    target=["pkgdev-manifests"],
    source=[],
    action=["${PKGDEV} manifest ${PKGDEV_DEFAULT_OPTS} ${PKGDEV_EXTRA_OPTS} ${PWD}"],
)
env.AlwaysBuild(pkgdev_manifests)

egencache_cache = env.Command(
    target=["egencache-cache"],
    source=[],
    action=["${EGENCACHE} ${EGENCACHE_DEFAULT_OPTS} ${EGENCACHE_EXTRA_OPTS} --repo myov"],
)
env.AlwaysBuild(egencache_cache)

pkgcheck_cache = env.Command(
    target=["pkgcheck-cache"],
    source=[],
    action=["${PKGCHECK} cache --update"],
)
env.AlwaysBuild(pkgcheck_cache)

ebuild_cache = env.Alias(
    target=["ebuild-cache"],
    source=[
        egencache_cache,
        pkgcheck_cache,
    ],
)
env.AlwaysBuild(ebuild_cache)

pkgcheck_scan_files = env.Command(
    target=["pkgcheck-scan-files"],
    source=[],
    action=["${PKGCHECK} scan ${PKGCHECK_DEFAULT_OPTS} ${PKGCHECK_EXTRA_OPTS}"],
)
env.Depends(
    target=[pkgcheck_scan_files],
    dependency=[
        ebuild_cache,
        pkgcheck_cache,
    ],
)
env.AlwaysBuild(pkgcheck_scan_files)

pkgcheck_scan_commits = env.Command(
    target=["pkgcheck-scan-commits"],
    source=[],
    action=[
        "${PKGCHECK} scan ${PKGCHECK_DEFAULT_OPTS} ${PKGCHECK_EXTRA_OPTS} --commits || :"
    ],
)
env.Depends(
    target=[pkgcheck_scan_commits],
    dependency=[
        ebuild_cache,
        pkgcheck_cache,
    ],
)
env.AlwaysBuild(pkgcheck_scan_commits)

pkgcheck_scan = env.Alias(
    target=["pkgcheck-scan"],
    source=[
        pkgcheck_scan_files,
        pkgcheck_scan_commits,
    ],
)
env.AlwaysBuild(pkgcheck_scan)

push_all = env.Command(
    target=["push-all"],
    source=[admin.File("push_all.bash")],
    action=["bash ${SOURCE}"],
)
env.AlwaysBuild(push_all)


all = env.Alias(
    target=["all"],
    source=[
        pkgdev_manifests,
        pkgcheck_scan,
    ],
)

Clean(
    targets=[
        "all",
    ],
    files=[
        "metadata/md5-cache",
    ],
)

Default("all")
