# DEPRECATED
This project is no longer receiving updates. Development has been subsumed to https://github.com/cerisier/toolchains_llvm_bootstrapped which provides smaller, more optimized, and more feature complete toolchain distributions, as well as a fully featured Bazel cc_toolchain, with full support for LLVM runtimes, sanitizers, from-source bootstraps, and more.

If you are only interested in consuming a statically-linked prebuilt LLVM, look for an [LLVM prebuilts release](https://github.com/cerisier/toolchains_llvm_bootstrapped/releases).
If you are a Bazel user, check the [README for directions](https://github.com/cerisier/toolchains_llvm_bootstrapped/blob/main/README.md) how to integrate into your build.

Please migrate your usage and reach out to us on that repository!

# Historical README
This repository builds a custom LLVM distribution that comes with statically linked tools (clang, lld, llvm-ar, llvm-as, llvm-nm, llvm-objcopy). This is the minimum set needed to use the outputs as a Bazel cc toolchain with [toolchains_llvm](https://github.com/bazel-contrib/toolchains_llvm) (previously grailbio/bazel-toolchain).

### Linux
On Linux, we link against musl libc.

### OSX
On OSX, fully statically linked executable is impossible. We dynamically link only libSystem.

## Usage
The easiest way to consume this is to check the [releases](https://github.com/dzbarsky/static-clang/releases) page for pre-built artifacts.
See [the example in toolchains_llvm](https://github.com/bazel-contrib/toolchains_llvm/blob/b3c96d2dbc698eab752366bbe747e2a7df7fa504/tests/MODULE.bazel#L97-L121) for where the artifact URLs should be configured.

### Building from source
You can also compile from source as follows:
1. [Install Bazelisk](--remote_header=x-buildbuddy-api-key=)
2. (Optional, but highly recommended). Setup remote execution by making a free account with [Buildbuddy](https://app.buildbuddy.io/). Add the following to your `.bazelrc` or `~/.bazelrc`: `build --remote_header=x-buildbuddy-api-key=YOUR_KEY_HERE`
3. Build for your platform: `bazel build //:dist`

You can also cross-compile for a different platform:
- `bazel build //:for_darwin_amd64`
- `bazel build //:for_darwin_arm64`
- `bazel build //:for_linux_arm64_musl`
- `bazel build //:for_linux_amd64_musl`
- `bazel build //:for_all_platforms` (builds all of the above)

## Roadmap
Please migrate to https://github.com/cerisier/toolchains_llvm_bootstrapped to continue following along our [roadmap](https://github.com/cerisier/toolchains_llvm_bootstrapped/milestone/1).
