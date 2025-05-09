load("@aspect_bazel_lib//lib:copy_file.bzl", "copy_file")
load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@llvm-project//:vars.bzl", "LLVM_VERSION_MAJOR")
load("@rules_pkg//pkg:mappings.bzl", "pkg_attributes", "pkg_files")
load("@rules_pkg//pkg:pkg.bzl", "pkg_tar")

pkg_files(
    name = "builtin_headers_pkg_files",
    srcs = [
        "@llvm-project//clang:builtin_headers_files",
    ],
    prefix = "lib/clang/%s/include" % LLVM_VERSION_MAJOR,
    strip_prefix = "lib/Headers",
)

TIER2_BINS = [
    "llvm-cov",
    "llvm-dwp",
    "llvm-objdump",
    "llvm-profdata",
]

DIST_FLAVORS = {
    "_minimal": {
        "extra_empty_files": ["bin/" + bin for bin in TIER2_BINS],
    },
    "": {
        "extra_bins": ["@llvm-project//llvm:" + bin for bin in TIER2_BINS],
    },
}

[
    pkg_files(
        name = "bins" + suffix,
        srcs = [
            "@llvm-project//clang",
            "@llvm-project//lld",
            "@llvm-project//llvm:llvm-ar",
            "@llvm-project//llvm:llvm-as",
            "@llvm-project//llvm:llvm-libtool-darwin",
            "@llvm-project//llvm:llvm-nm",
            "@llvm-project//llvm:llvm-objcopy",
        ] + props.get("extra_bins", []),
        attributes = pkg_attributes(
            mode = "0755",
        ),
        prefix = "bin",
    )
    for (suffix, props) in DIST_FLAVORS.items()
]

# Note, there are some inconsistencies in naming so expanding the templates.
LIB_PREFIX = "lib/clang/%s/lib/" % LLVM_VERSION_MAJOR

copy_file(
    name = "copy_libclang_rt.profile_osx",
    src = "@llvm-project//compiler-rt:profile",
    out = "libclang_rt.profile_osx.a",
)

pkg_files(
    name = "libclang_rt.profile_osx",
    srcs = ["libclang_rt.profile_osx.a"],
    prefix = LIB_PREFIX + "darwin",
)

copy_file(
    name = "copy_libclang_rt.profile_aarch64",
    src = "@llvm-project//compiler-rt:profile",
    out = "libclang_rt.profile-aarch64.a",
)

pkg_files(
    name = "libclang_rt.profile_aarch64",
    srcs = ["libclang_rt.profile-aarch64.a"],
    prefix = LIB_PREFIX + "linux",
)

copy_file(
    name = "copy_libclang_rt.profile_x84_64",
    src = "@llvm-project//compiler-rt:profile",
    out = "libclang_rt.profile-x86_64.a",
)

pkg_files(
    name = "libclang_rt.profile_x86_64",
    srcs = ["libclang_rt.profile-x86_64.a"],
    prefix = LIB_PREFIX + "linux",
)

[
    pkg_tar(
        name = "dist" + suffix,
        srcs = [
            ":bins" + suffix,
            "//:builtin_headers_pkg_files",
            "@llvm-raw//:libcxx_include",
        ] + select({
            "@bazel_tools//src/conditions:darwin": [":libclang_rt.profile_osx"],
            "@bazel_tools//src/conditions:linux_aarch64": [":libclang_rt.profile_aarch64"],
            "@bazel_tools//src/conditions:linux_x86_64": [":libclang_rt.profile_x86_64"],
        }),
        empty_files = props.get("extra_empty_files", []),
        extension = ".tar.xz",
        symlinks = {
            "bin/clang++": "./clang",
            "bin/clang-cpp": "./clang",
            "bin/ld.lld": "./lld",
            "bin/ld64.lld": "./lld",
            "bin/wasm-ld": "./lld",
            "bin/llvm-strip": "./llvm-objcopy",
        },
    )
    for (suffix, props) in DIST_FLAVORS.items()
]

PLATFORMS = [
    "@zig_sdk//platform:darwin_amd64",
    "@zig_sdk//platform:darwin_arm64",
    "@zig_sdk//libc_aware/platform:linux_arm64_musl",
    "@zig_sdk//libc_aware/platform:linux_amd64_musl",
]

[
    platform_transition_filegroup(
        name = "for_" + platform.split(":")[1],
        srcs = [
            ":dist",
            ":dist_minimal",
        ],
        target_platform = platform,
    )
    for platform in PLATFORMS
]

filegroup(
    name = "for_all_platforms",
    srcs = ["for_" + platform.split(":")[1] for platform in PLATFORMS],
)
