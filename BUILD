load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@llvm-project//:vars.bzl", "LLVM_VERSION_MAJOR")
load("@rules_pkg//pkg:pkg.bzl", "pkg_tar")
load("@rules_pkg//pkg:mappings.bzl", "pkg_files")

pkg_files(
    name = "bins",
    srcs = [
        "@llvm-project//clang",
        "@llvm-project//lld",
        "@llvm-project//llvm:llvm-ar",
        "@llvm-project//llvm:llvm-as",
        "@llvm-project//llvm:llvm-nm",
        "@llvm-project//llvm:llvm-objcopy",
    ],
    prefix = "bin",
)

pkg_files(
    name = "builtin_headers_pkg_files",
    srcs = [
        "@llvm-project//clang:builtin_headers_files",
    ],
    prefix = "lib/clang/%s/include" % LLVM_VERSION_MAJOR,
    strip_prefix = "lib/Headers",
)

pkg_tar(
    name = "dist",
    srcs = [
        ":bins",
        "//:builtin_headers_pkg_files",
        "@llvm-raw//:libcxx_include",
    ],
    empty_files = [
        "bin/llvm-cov",
        "bin/llvm-dwp",
        "bin/llvm-objdump",
        "bin/llvm-profdata",
    ],
    symlinks = {
        "bin/clang++": "./clang",
        "bin/clang-cpp": "./clang",
        "bin/ld.lld": "./lld",
        "bin/llvm-strip": "./llvm-objcopy",
    },
    #extension = ".tar.xz",
)

PLATFORMS = [
    "@zig_sdk//platform:darwin_amd64",
    "@zig_sdk//platform:darwin_arm64",
    "@zig_sdk//libc_aware/platform:linux_arm64_musl",
    "@zig_sdk//libc_aware/platform:linux_amd64_musl",
]

[
    platform_transition_filegroup(
        name = "for_" + platform.split(":")[1],
        srcs = [":dist"],
        target_platform = platform,
    )
    for platform in PLATFORMS
]

filegroup(
    name = "for_all_platforms",
    srcs = ["for_" + platform.split(":")[1] for platform in PLATFORMS],
)
