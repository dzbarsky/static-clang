set -eux

bazel build --remote_header=x-buildbuddy-api-key="$BUILDBUDDY_API_KEY" //:for_all_platforms

mv bazel-out/darwin_amd64-opt/bin/dist.tar.zst darwin_amd64.tar.zst
mv bazel-out/darwin_amd64-opt/bin/dist_minimal.tar.zst darwin_amd64_minimal.tar.zst

mv bazel-out/darwin_arm64-opt/bin/dist.tar.zst darwin_arm64.tar.zst
mv bazel-out/darwin_arm64-opt/bin/dist_minimal.tar.zst darwin_arm64_minimal.tar.zst

mv bazel-out/linux_arm64_musl-opt/bin/dist.tar.zst linux_arm64.tar.zst
mv bazel-out/linux_arm64_musl-opt/bin/dist_minimal.tar.zst linux_arm64_minimal.tar.zst

mv bazel-bin/dist.tar.zst linux_amd64.tar.zst
mv bazel-bin/dist_minimal.tar.zst linux_amd64_minimal.tar.zst

shasum -a 256 *tar.zst > SHA256.txt
