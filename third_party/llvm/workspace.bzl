"""Provides the repository macro to import LLVM."""

load("//third_party:repo.bzl", "tf_http_archive")

def repo(name):
    """Imports LLVM."""
    LLVM_COMMIT = "a58d0af058038595c93de961b725f86997cf8d4a"
    LLVM_SHA256 = "1dba887aeb4970b55199b4002bf1628a93dac65925f2e2f9a44e0528705d1e52"

    tf_http_archive(
        name = name,
        sha256 = LLVM_SHA256,
        strip_prefix = "llvm-project-{commit}".format(commit = LLVM_COMMIT),
        urls = [
            "https://storage.googleapis.com/mirror.tensorflow.org/github.com/llvm/llvm-project/archive/{commit}.tar.gz".format(commit = LLVM_COMMIT),
            "https://github.com/llvm/llvm-project/archive/{commit}.tar.gz".format(commit = LLVM_COMMIT),
        ],
        build_file = "//third_party/llvm:llvm.BUILD",
        patch_file = ["//third_party/llvm:macos_build_fix.patch", "//third_party/llvm:fix_ppc64le.patch", "//third_party/llvm:disable_typeid_check.patch"],
        link_files = {"//third_party/llvm:run_lit.sh": "mlir/run_lit.sh"},
    )
