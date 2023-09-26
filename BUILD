load("@rules_pkg//pkg:pkg.bzl", "pkg_tar")
load("@rules_pkg//pkg:mappings.bzl", "pkg_files")

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
    empty_files = [
        "llvm-cov",
        "llvm-dwp",
        "llvm-objdump",
        "llvm-profdata",
    ],
)

#pkg_tar(
#    name = "clang_lib_headers",
#    srcs = [
#        "@llvm-raw//:clang_lib_headers",
#    ],
#    package_dir = "lib/clang/17.0.1/include",
#)
#
#pkg_files(
#    name = "libcxx_include",
#    srcs = [
#        "@llvm-raw//:libcxx_include",
#    ],
#    prefix = "include/c++/v1",
#)

pkg_tar(
    name = "dist",
    deps = [
        ":clang_bins",
        ":lld_bins",
        ":llvm_bins",
	":@llvm-raw//:libcxx_include",
    ],
)

pkg_tar(
    name = "xz_dist",
    extension = ".tar.xz",
    deps = [":dist"],
)
