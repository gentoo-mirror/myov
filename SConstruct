# Copyright (c) 2024-2025, Maciej Barć <xgqt@xgqt.org>

# Documentation: https://scons.org/doc/production/HTML/scons-man.html


import os

from shutil import which

from SCons.Script import (
    Clean,
    Default,
    Dir,
    EnsurePythonVersion,
    EnsureSConsVersion,
    Environment,
    Glob,
    Touch,
    Variables,
)


venv_path = os.path.abspath(".venv")
activate_this_py = os.path.join(venv_path, "bin", "activate_this.py")

if os.path.exists(activate_this_py):
    activate_this_py_contents = open(activate_this_py).read()

    exec(activate_this_py_contents, {"__file__": activate_this_py})


pwd = Dir(".")

aux = pwd.Dir(".aux")
admin = aux.Dir("admin")


EnsurePythonVersion(3, 12)
EnsureSConsVersion(4, 9)


tools = [
    "default",
]

opts = Variables()


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

env["AUX"] = aux.srcnode().abspath
env["ADMIN"] = admin.srcnode().abspath


ebuilds = Glob("*/*/*.ebuild")


ebuild_builds = []

for ebuild in ebuilds:
    ebuild_build = env.Command(
        target=[ebuild.srcnode().relpath + ".ebuilt.stamp"],
        source=[
            admin.File("build_package.bash"),
            ebuild,
        ],
        action=[
            "bash ${SOURCES} test clean",
            #
            Touch("${TARGET}"),
        ],
    )

    ebuild_builds.append(ebuild_build)


pkgdev_manifests_cmd_args = [
    "${PKGDEV}",
    "manifest",
    "${PKGDEV_DEFAULT_OPTS}",
    "${PKGDEV_EXTRA_OPTS}",
    "${PWD}",
]
manifests = env.Command(
    target=["target/manifests.stamp"],
    source=[
        ebuilds,
    ],
    action=[
        " ".join(pkgdev_manifests_cmd_args),
        #
        Touch("${TARGET}"),
    ],
)

pkgcheck_cache_cmd_args = [
    "${PKGCHECK}",
    "cache",
    "--update",
]
pkgcheck_cache = env.Command(
    target=["target/pkgcheck-cache.stamp"],
    source=[
        ebuilds,
    ],
    action=[
        " ".join(pkgcheck_cache_cmd_args),
        #
        Touch("${TARGET}"),
    ],
)

ebuild_cache = env.Command(
    target=["target/ebuild-cache.stamp"],
    source=[
        pkgcheck_cache,
    ],
    action=[
        #
        Touch("${TARGET}"),
    ],
)

pkgcheck_scan_files_cmd_args = [
    "${PKGCHECK}",
    "scan",
    "${PKGCHECK_DEFAULT_OPTS}",
    "${PKGCHECK_EXTRA_OPTS}",
]
pkgcheck_scan_files = env.Command(
    target=["target/pkgcheck-scan-files.stamp"],
    source=[
        ebuilds,
        ebuild_cache,
        pkgcheck_cache,
    ],
    action=[
        " ".join(pkgcheck_scan_files_cmd_args),
        #
        Touch("${TARGET}"),
    ],
)

pkgcheck_scan_commits_cmd_args = [
    "${PKGCHECK}",
    "scan",
    "${PKGCHECK_DEFAULT_OPTS}",
    "${PKGCHECK_EXTRA_OPTS}",
    "--commits",
]
pkgcheck_scan_commits = env.Command(
    target=["target/pkgcheck-scan-commits.stamp"],
    source=[],
    action=[
        " ".join(pkgcheck_scan_commits_cmd_args)
        + " || echo 'WARNING: Commits scan failed'",
        #
        Touch("${TARGET}"),
    ],
)

pkgcheck_scan = env.Command(
    target=["target/pkgcheck-scan.stamp"],
    source=[
        pkgcheck_scan_files,
        pkgcheck_scan_commits,
    ],
    action=[
        #
        Touch("${TARGET}"),
    ],
)

smoke = env.Command(
    target=["target/smoke.stamp"],
    source=[
        # Ensure some categories build correctly.
        "app-portage",
        #
        # Ensure some packages build correctly.
        "dev-build/jam",
        "games-misc/dice",
    ],
    action=[
        #
        Touch("${TARGET}"),
    ],
)


build_stamp = env.Command(
    target=["target/build.stamp"],
    source=[
        manifests,
        ebuild_cache,
    ],
    action=[
        #
        Touch("${TARGET}"),
    ],
)

build = env.Alias(
    target=["build"],
    source=[build_stamp],
)

test_stamp = env.Command(
    target=["target/test.stamp"],
    source=[
        pkgcheck_scan,
        smoke,
    ],
    action=[
        #
        Touch("${TARGET}"),
    ],
)

test = env.Alias(
    target=["test"],
    source=[test_stamp],
)


push = env.Command(
    target=["push"],
    source=[
        admin.File("push_all.bash"),
    ],
    action=[
        "bash ${SOURCE}",
    ],
)

env.AlwaysBuild(push)


all = env.Alias(
    target=["all"],
    source=[
        build,
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
