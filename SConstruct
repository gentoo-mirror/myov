# Copyright (c) 2024-2025, Maciej Barć <xgqt@xgqt.org>

# Documentation: https://scons.org/doc/production/HTML/scons-man.html


import os

from shutil import which

from SCons.Script import Clean
from SCons.Script import Default
from SCons.Script import Dir
from SCons.Script import Environment
from SCons.Script import Glob
from SCons.Script import Variables


venv_path = os.path.abspath(".venv")
activate_this_py = os.path.join(venv_path, "bin", "activate_this.py")

if os.path.exists(activate_this_py):
    activate_this_py_contents = open(activate_this_py).read()

    exec(activate_this_py_contents, {"__file__": activate_this_py})


pwd = Dir(".")

cache = pwd.Dir(".cache")
aux = pwd.Dir(".aux")
admin = aux.Dir("admin")


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

orig_env["LANG"] = "C"

# Setup for unprivileged user.
if os.getuid() != 0:
    orig_env["PORTAGE_USERNAME"] = os.getlogin()
    orig_env["PORTAGE_INST_UID"] = os.getuid()
    orig_env["PORTAGE_INST_GID"] = os.getgid()


env = Environment(
    ENV=orig_env,
    variables=opts,
    tools=tools,
)


env["PWD"] = pwd.srcnode().abspath

env["CACHE"] = cache.srcnode().abspath
env["AUX"] = aux.srcnode().abspath
env["ADMIN"] = admin.srcnode().abspath


build_all = env.Command(
    target=["build-all"],
    source=[
        admin.File("build_all.bash"),
    ],
    action=[
        "bash ${SOURCE}",
    ],
)
env.AlwaysBuild(build_all)

pkgdev_manifests_cmd_args = [
    "${PKGDEV}",
    "manifest",
    "${PKGDEV_DEFAULT_OPTS}",
    "${PKGDEV_EXTRA_OPTS}",
    "${PWD}",
]
pkgdev_manifests = env.Command(
    target=["pkgdev-manifests"],
    source=[],
    action=[
        " ".join(pkgdev_manifests_cmd_args),
    ],
)
env.AlwaysBuild(pkgdev_manifests)

egencache_cache_cmd_args = [
    "${EGENCACHE}",
    "${EGENCACHE_DEFAULT_OPTS}",
    "${EGENCACHE_EXTRA_OPTS}",
    "--repo=myov",
]
egencache_cache = env.Command(
    target=["egencache-cache"],
    source=[],
    action=[
        " ".join(egencache_cache_cmd_args),
    ],
)
env.AlwaysBuild(egencache_cache)

pkgcheck_cache_cmd_args = [
    "${PKGCHECK}",
    "cache",
    "--update",
]
pkgcheck_cache = env.Command(
    target=["pkgcheck-cache"],
    source=[],
    action=[
        " ".join(pkgcheck_cache_cmd_args),
    ],
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

pkgcheck_scan_files_cmd_args = [
    "${PKGCHECK}",
    "scan",
    "${PKGCHECK_DEFAULT_OPTS}",
    "${PKGCHECK_EXTRA_OPTS}",
]
pkgcheck_scan_files = env.Command(
    target=["pkgcheck-scan-files"],
    source=[],
    action=[
        " ".join(pkgcheck_scan_files_cmd_args),
    ],
)
env.Depends(
    target=[pkgcheck_scan_files],
    dependency=[
        ebuild_cache,
        pkgcheck_cache,
    ],
)
env.AlwaysBuild(pkgcheck_scan_files)

pkgcheck_scan_commits_cmd_args = [
    "${PKGCHECK}",
    "scan",
    "${PKGCHECK_DEFAULT_OPTS}",
    "${PKGCHECK_EXTRA_OPTS}",
    "--commits",
]
pkgcheck_scan_commits = env.Command(
    target=["pkgcheck-scan-commits"],
    source=[],
    action=[
        " ".join(pkgcheck_scan_commits_cmd_args)
        + " || echo 'WARNING: Commits scan failed'",
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


ebuilds = Glob("*/*/*.ebuild")
ebuild_builds = []

for ebuild in ebuilds:
    ebuild_build = env.Command(
        target=[ebuild.srcnode().relpath + ".ebuilt"],
        source=[
            admin.File("build_package.bash"),
            ebuild,
        ],
        action=[
            "bash ${SOURCES} test clean",
            "date +%s > ${TARGET}",
        ],
    )

    ebuild_builds.append(ebuild_build)


smoke = env.Alias(
    target=["smoke"],
    source=[
        # Ensure some categories build correctly.
        "app-portage",
        #
        # Ensure some packages build correctly.
        "dev-build/jam",
        "games-misc/dice",
    ],
)
env.AlwaysBuild(smoke)

test = env.Alias(
    target=["test"],
    source=[
        pkgcheck_scan,
        smoke,
    ],
)
env.AlwaysBuild(test)


push_all = env.Command(
    target=["push-all"],
    source=[
        admin.File("push_all.bash"),
    ],
    action=[
        "bash ${SOURCE}",
    ],
)
env.AlwaysBuild(push_all)


all = env.Alias(
    target=["all"],
    source=[
        pkgdev_manifests,
        test,
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
