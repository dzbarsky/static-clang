workspace(name = "static_clang")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

## Start LLVM ##
# See https://github.com/llvm/llvm-project/blob/7cbf1a2591520c2491aa35339f227775f4d3adf6/utils/bazel/WORKSPACE
SKYLIB_VERSION = "1.3.0"

http_archive(
    name = "bazel_skylib",
    sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version = SKYLIB_VERSION),
        "https://github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version = SKYLIB_VERSION),
    ],
)

LLVM_COMMIT = "6009708b4367171ccdbf4b5905cb6a803753fe18"  # 17.0.6

LLVM_SHA256 = "1b0dd2e445ebe7406f4982cb39de02f8c07f19e6ef2182e49164d9e6421dc9ec"

http_archive(
    name = "llvm-raw",
    build_file = "//:BUILD.llvm-raw",
    patch_args = ["-p1"],
    patches = ["//:llvm.patch"],
    sha256 = LLVM_SHA256,
    strip_prefix = "llvm-project-" + LLVM_COMMIT,
    urls = ["https://github.com/llvm/llvm-project/archive/{commit}.tar.gz".format(commit = LLVM_COMMIT)],
)

load("@llvm-raw//utils/bazel:configure.bzl", "llvm_configure")

llvm_configure(name = "llvm-project")

maybe(
    http_archive,
    name = "llvm_zlib",
    build_file = "@llvm-raw//utils/bazel/third_party_build:zlib-ng.BUILD",
    sha256 = "e36bb346c00472a1f9ff2a0a4643e590a254be6379da7cddd9daeb9a7f296731",
    strip_prefix = "zlib-ng-2.0.7",
    urls = [
        "https://github.com/zlib-ng/zlib-ng/archive/refs/tags/2.0.7.zip",
    ],
)

maybe(
    http_archive,
    name = "vulkan_headers",
    build_file = "@llvm-raw//utils/bazel/third_party_build:vulkan_headers.BUILD",
    sha256 = "19f491784ef0bc73caff877d11c96a48b946b5a1c805079d9006e3fbaa5c1895",
    strip_prefix = "Vulkan-Headers-9bd3f561bcee3f01d22912de10bb07ce4e23d378",
    urls = [
        "https://github.com/KhronosGroup/Vulkan-Headers/archive/9bd3f561bcee3f01d22912de10bb07ce4e23d378.tar.gz",
    ],
)

load("@llvm-raw//utils/bazel:vulkan_sdk.bzl", "vulkan_sdk_setup")

maybe(
    vulkan_sdk_setup,
    name = "vulkan_sdk",
)

maybe(
    http_archive,
    name = "llvm_zstd",
    build_file = "@llvm-raw//utils/bazel/third_party_build:zstd.BUILD",
    sha256 = "7c42d56fac126929a6a85dbc73ff1db2411d04f104fae9bdea51305663a83fd0",
    strip_prefix = "zstd-1.5.2",
    urls = [
        "https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-1.5.2.tar.gz",
    ],
)
## END LLVM ##
