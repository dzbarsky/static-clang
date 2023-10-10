set -eux

bazel build --remote_header=x-buildbuddy-api-key="$BUILDBUDDY_API_KEY" //:for_all_platforms

mv bazel-out/darwin_amd64-opt-ST-4e8d1fe9d83a/bin/dist.tar.xz darwin_amd64.tar.xz
#mv bazel-out/darwin_amd64-opt-ST-4e8d1fe9d83a/bin/dist_minimal.tar.xz darwin_amd64_minimal.tar.xz

mv bazel-out/darwin_arm64-opt-ST-c94fc642ad67/bin/dist.tar.xz darwin_arm64.tar.xz
#mv bazel-out/darwin_arm64-opt-ST-c94fc642ad67/bin/dist_minimal.tar.xz darwin_arm64_minimal.tar.xz

mv bazel-out/linux_arm64_musl-opt-ST-f0306bd6469b/bin/dist.tar.xz linux_arm64.tar.xz
#mv bazel-out/linux_arm64_musl-opt-ST-f0306bd6469b/bin/dist_minimal.tar.xz linux_arm64_minimal.tar.xz

mv bazel-out/linux_amd64_musl-opt-ST-83633c55e68c/bin/dist.tar.xz linux_amd64.tar.xz
#mv bazel-out/linux_amd64_musl-opt-ST-83633c55e68c/bin/dist_minimal.tar.xz linux_amd64_minimal.tar.xz

shasum -a 256 *tar.xz > SHA256.txt
