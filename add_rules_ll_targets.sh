set -eux

LL_DIR="/tmp/rules_ll"
#git clone https://github.com/eomii/rules_ll.git "$LL_DIR"
#git clone https://github.com/llvm/llvm-project.git /tmp/llvm-project

cd "$LL_DIR/llvm-project-overlay"
FILES="$(find . -type f)"
for FILE in $FILES; do
    mkdir -p /tmp/llvm-project/utils/bazel/llvm-project-overlay/"$(dirname $FILE)"
    OUT="/tmp/llvm-project/utils/bazel/llvm-project-overlay/$FILE"
    cp "$FILE" "$OUT"
    sed -i 's/@rules_ll\/\/ll:defs.bzl/@@\/\/:rules_ll_compat.bzl/g' $OUT
done

cd /tmp/llvm-project/
# Not sure what to do with compiler-rt yet.
git checkout utils/bazel/llvm-project-overlay/compiler-rt/BUILD.bazel
git add .
git diff --staged > /static-clang/llvm_extra_targets.patch
git reset --hard