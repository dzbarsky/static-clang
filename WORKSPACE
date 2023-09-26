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
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version=SKYLIB_VERSION),
        "https://github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version=SKYLIB_VERSION),
    ],
)

LLVM_COMMIT = "7cbf1a2591520c2491aa35339f227775f4d3adf6"
LLVM_SHA256 = "c78c94b2a03b2cf6ef1ba035c31a6f1b0bb7913da8af5aa8d5c2061f6499d589"

http_archive(
    name = "llvm-raw",
    build_file_content = "# empty",
    #sha256 = LLVM_SHA256,
    strip_prefix = "llvm-project-" + LLVM_COMMIT,
    urls = ["https://github.com/llvm/llvm-project/archive/{commit}.tar.gz".format(commit = LLVM_COMMIT)],
)

load("@llvm-raw//utils/bazel:configure.bzl", "llvm_configure")

llvm_configure(name = "llvm-project")

load("@llvm-raw//utils/bazel:terminfo.bzl", "llvm_terminfo_from_env")

maybe(
    llvm_terminfo_from_env,
    name = "llvm_terminfo",
)

maybe(
    http_archive,
    name = "zlib",
    build_file = "@llvm-raw//utils/bazel/third_party_build:zlib.BUILD",
    sha256 = "91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9",
    strip_prefix = "zlib-1.2.12",
    urls = [
        "https://storage.googleapis.com/mirror.tensorflow.org/zlib.net/zlib-1.2.12.tar.gz",
        "https://zlib.net/zlib-1.2.12.tar.gz",
    ],
)

load("@llvm-raw//utils/bazel:zlib.bzl", "llvm_zlib_from_env")

maybe(
    llvm_zlib_from_env,
    name = "llvm_zlib",
    external_zlib = "@zlib",
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
        "https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-1.5.2.tar.gz"
    ],
)

http_archive(
    name = "io_buildbuddy_buildbuddy_toolchain",
    sha256 = "e899f235b36cb901b678bd6f55c1229df23fcbc7921ac7a3585d29bff2bf9cfd",
    strip_prefix = "buildbuddy-toolchain-fd351ca8f152d66fc97f9d98009e0ae000854e8f",
    urls = ["https://github.com/buildbuddy-io/buildbuddy-toolchain/archive/fd351ca8f152d66fc97f9d98009e0ae000854e8f.tar.gz"],
)
## END LLVM ##

load("@io_buildbuddy_buildbuddy_toolchain//:deps.bzl", "buildbuddy_deps")

buildbuddy_deps()

load("@io_buildbuddy_buildbuddy_toolchain//:rules.bzl", "buildbuddy")

buildbuddy(name = "buildbuddy_toolchain")

local_repository(
    name = "rbe_default",
    path = "configs/rbe_default",
)

## ZIG CC ##
HERMETIC_CC_TOOLCHAIN_VERSION = "v2.1.2"

http_archive(
    name = "hermetic_cc_toolchain",
    sha256 = "28fc71b9b3191c312ee83faa1dc65b38eb70c3a57740368f7e7c7a49bedf3106",
    urls = [
        "https://mirror.bazel.build/github.com/uber/hermetic_cc_toolchain/releases/download/{0}/hermetic_cc_toolchain-{0}.tar.gz".format(HERMETIC_CC_TOOLCHAIN_VERSION),
        "https://github.com/uber/hermetic_cc_toolchain/releases/download/{0}/hermetic_cc_toolchain-{0}.tar.gz".format(HERMETIC_CC_TOOLCHAIN_VERSION),
    ],
)

load("@hermetic_cc_toolchain//toolchain:defs.bzl", zig_toolchains = "toolchains")

# Plain zig_toolchains() will pick reasonable defaults. See
# toolchain/defs.bzl:toolchains on how to change the Zig SDK version and
# download URL.
zig_toolchains()

register_toolchains(
    "@zig_sdk//libc_aware/toolchain:x86_64-linux-musl",
    #"@zig_sdk//toolchain:darwin_amd64",
    #"@zig_sdk//toolchain:darwin_arm64",
)
