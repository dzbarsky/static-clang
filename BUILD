load("@bazel_lib//lib:copy_file.bzl", "copy_file")
load("@bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@llvm-project//:vars.bzl", "LLVM_VERSION_MAJOR")
load("@tar.bzl", "mtree_mutate", "mtree_spec", "tar")
load("//:defs.bzl", "file", "link", "empty", "mtree")

# .stripped is not buildable when using hermetic_cc_toolchain because it doesn't expose the strip binary
BUILD_STRIPPED = False

TIER1_BINS = [
    "@llvm-project//clang:clang{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//lld:lld{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-ar{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-as{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-libtool-darwin{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-nm{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-objcopy{}".format(".stripped" if BUILD_STRIPPED else ""),
]

TIER2_BINS = [
    "@llvm-project//llvm:llvm-cov{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-dwp{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-objdump{}".format(".stripped" if BUILD_STRIPPED else ""),
    "@llvm-project//llvm:llvm-profdata{}".format(".stripped" if BUILD_STRIPPED else ""),
]

mtree_spec(
    name = "libcxx_include_mtree_",
    srcs = ["@llvm-raw//:libcxx_include"],
)

mtree_mutate(
    name = "libcxx_include_mtree",
    mtree = "libcxx_include_mtree_",
    strip_prefix = "libcxx/include",
    package_dir = "include/c++/v1",
)

mtree_spec(
    name = "libcxxabi_include_mtree_",
    srcs = ["@llvm-raw//:libcxxabi_include"],
)

mtree_mutate(
    name = "libcxxabi_include_mtree",
    mtree = "libcxxabi_include_mtree_",
    strip_prefix = "libcxxabi/include",
    package_dir = "include/c++/v1",
)

mtree_spec(
    name = "builtin_headers_mtree_",
    srcs = ["@llvm-project//clang:builtin_headers_files"],
)

mtree_mutate(
    name = "builtin_headers_mtree",
    mtree = "builtin_headers_mtree_",
    strip_prefix = "clang/lib/Headers",
    package_dir = "lib/clang/%s/include" % LLVM_VERSION_MAJOR,
)

# Note, there are some inconsistencies in naming so expanding the templates.
LIB_PREFIX = "lib/clang/%s/lib/" % LLVM_VERSION_MAJOR

mtree(
    name = "libclang_rt.profile_osx_mtree",
    srcs = ["@llvm-project//compiler-rt:profile"],
    contents = [
        file(LIB_PREFIX + "darwin/libclang_rt.profile_osx.a", "@llvm-project//compiler-rt:profile"),
    ],
    outs = ["libclang_rt.profile_osx.mtree"],
)

mtree(
    name = "libclang_rt.profile_aarch64_mtree",
    srcs = ["@llvm-project//compiler-rt:profile"],
    contents = [
        file(LIB_PREFIX + "linux/libclang_rt.profile-aarch64.a", "@llvm-project//compiler-rt:profile"),
    ],
    outs = ["libclang_rt.profile_aarch64.mtree"],
)

mtree(
    name = "libclang_rt.profile_x86_64_mtree",
    srcs = ["@llvm-project//compiler-rt:profile"],
    contents = [
        file(LIB_PREFIX + "linux/libclang_rt.profile-x86_64.a", "@llvm-project//compiler-rt:profile"),
    ],
    outs = ["libclang_rt.profile_x86_64.mtree"],
)

alias(
    name = "libclang_rt_mtree",
    actual = select({
        "@bazel_tools//src/conditions:darwin": ":libclang_rt.profile_osx_mtree",
        "@bazel_tools//src/conditions:linux_aarch64": ":libclang_rt.profile_aarch64_mtree",
        "@bazel_tools//src/conditions:linux_x86_64": ":libclang_rt.profile_x86_64_mtree",
    }),
)

mtree(
    name = "tier1_bins_mtree",
    srcs = TIER1_BINS,
    contents = [
        file("bin/clang", "@llvm-project//clang:clang{strip_suffix}"),
        link("bin/clang-" + LLVM_VERSION_MAJOR, "clang"),
        link("bin/clang++", "clang"),
        link("bin/clang-cpp", "clang"),
        file("bin/lld", "@llvm-project//lld:lld{strip_suffix}"),
        link("bin/ld.lld", "lld"),
        link("bin/ld64.lld", "lld"),
        link("bin/wasm-ld", "lld"),
        file("bin/llvm-ar", "@llvm-project//llvm:llvm-ar{strip_suffix}"),
        file("bin/llvm-as", "@llvm-project//llvm:llvm-as{strip_suffix}"),
        file("bin/llvm-libtool-darwin", "@llvm-project//llvm:llvm-libtool-darwin{strip_suffix}"),
        file("bin/llvm-nm", "@llvm-project//llvm:llvm-nm{strip_suffix}"),
        file("bin/llvm-objcopy", "@llvm-project//llvm:llvm-objcopy{strip_suffix}"),
        link("bin/llvm-strip", "llvm-objcopy"),
        empty("bin/clang-tidy"),
        empty("bin/clang-format"),
        empty("bin/clangd"),
        empty("bin/llvm-symbolizer"),
    ],
    format = dict(
        strip_suffix = ".stripped" if BUILD_STRIPPED else "",
    ),
    outs = ["tier1_bins.mtree"],
)

mtree(
    name = "tier2_bins_mtree",
    srcs = TIER2_BINS,
    contents = [
        file("bin/llvm-cov", "@llvm-project//llvm:llvm-cov{strip_suffix}"),
        file("bin/llvm-dwp", "@llvm-project//llvm:llvm-dwp{strip_suffix}"),
        file("bin/llvm-objdump", "@llvm-project//llvm:llvm-objdump{strip_suffix}"),
        file("bin/llvm-profdata", "@llvm-project//llvm:llvm-profdata{strip_suffix}"),
    ],
    format = dict(
        strip_suffix = ".stripped" if BUILD_STRIPPED else "",
    ),
    outs = ["tier2_bins.mtree"],
)

genrule(
    name = "mtree",
    srcs = [
        ":builtin_headers_mtree",
        ":tier1_bins_mtree",
        ":tier2_bins_mtree",
        ":libclang_rt_mtree",
        ":libcxx_include_mtree",
        ":libcxxabi_include_mtree",
    ],
    cmd = """\
        cat $(location :builtin_headers_mtree) >> $(@)
        cat $(location :tier1_bins_mtree) >> $(@)
        cat $(location :tier2_bins_mtree) >> $(@)
        cat $(location :libclang_rt_mtree) >> $(@)
        cat $(location :libcxx_include_mtree) >> $(@)
        cat $(location :libcxxabi_include_mtree) >> $(@)
    """,
    outs = ["mtree_spec.mtree"],
)

tar(
    name = "dist",
    srcs = TIER1_BINS + TIER2_BINS + [
        "@llvm-project//compiler-rt:profile",
        "@llvm-project//clang:builtin_headers_files",
        "@llvm-raw//:libcxx_include",
        "@llvm-raw//:libcxxabi_include",
    ],
    args = [
        "--options",
        "zstd:compression-level=22",
    ],
    compress = "zstd",
    mtree = ":mtree",
)

mtree(
    name = "tier2_empty_mtree",
    contents = [
        empty("bin/llvm-cov"),
        empty("bin/llvm-dwp"),
        empty("bin/llvm-objdump"),
        empty("bin/llvm-profdata"),
    ],
    outs = ["tier2_empty.mtree"],
)

genrule(
    name = "minimal_mtree",
    srcs = [
        ":builtin_headers_mtree",
        ":tier1_bins_mtree",
        ":tier2_empty_mtree",
        ":libclang_rt_mtree",
        ":libcxx_include_mtree",
        ":libcxxabi_include_mtree",
    ],
    cmd = """\
        cat $(location :builtin_headers_mtree) >> $(@)
        cat $(location :tier1_bins_mtree) >> $(@)
        cat $(location :tier2_empty_mtree) >> $(@)
        cat $(location :libclang_rt_mtree) >> $(@)
        cat $(location :libcxx_include_mtree) >> $(@)
        cat $(location :libcxxabi_include_mtree) >> $(@)
    """,
    outs = ["minimal_mtree_spec.mtree"],
)

tar(
    name = "dist_minimal",
    srcs = TIER1_BINS + [
        "@llvm-project//compiler-rt:profile",
        "@llvm-project//clang:builtin_headers_files",
        "@llvm-raw//:libcxx_include",
        "@llvm-raw//:libcxxabi_include",
    ],
    args = [
        "--options",
        "zstd:compression-level=22",
    ],
    compress = "zstd",
    mtree = ":minimal_mtree",
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
