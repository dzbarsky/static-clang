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
This satifies my current needs, but I'm happy to tag additional releases as LLVM upstream releases them. I will probably add additional binaries that are used in Bazel as I need them: llvm-cov, llvm-dwp, llvm-objdump, llvm-profdata. I'm also open to adding extra pre-built artifacts with a more full set of tools (flang, clang-format, etc.) if there is interest.
