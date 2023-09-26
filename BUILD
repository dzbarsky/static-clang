load("@rules_pkg//pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "clang_bins",
    strip_prefix = "external/llvm-project/clang",
    package_dir = "bin",
    srcs = [
        "@llvm-project//clang",
    ],
    symlinks = {
        "clang++": "./clang",
        "clang-cpp": "./clang",
    },
)

pkg_tar(
    name = "lld_bins",
    strip_prefix = "external/llvm-project/lld",
    package_dir = "bin",
    srcs = [
        "@llvm-project//lld",
    ],
    symlinks = {
        "ld.lld": "./lld",
    },
)


pkg_tar(
    name = "llvm_bins",
    strip_prefix = "external/llvm-project/llvm",
    package_dir = "bin",
    srcs = [
        "@llvm-project//llvm:llvm-ar",
        "@llvm-project//llvm:llvm-as",
        "@llvm-project//llvm:llvm-nm",
        "@llvm-project//llvm:llvm-objcopy",
    ],
    symlinks = {
        "llvm-strip": "./llvm-objcopy",
    },
)

pkg_tar(
    name = "dist",
    deps = [
        ":clang_bins",
        ":lld_bins",
        ":llvm_bins",
    ],
)

pkg_tar(
    name = "gz_dist",
    extension = ".tar.gz",
    deps = [":dist"],
)

pkg_tar(
    name = "xz_dist",
    extension = ".tar.xz",
    deps = [":dist"],
)
