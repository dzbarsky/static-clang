package(default_visibility = ["//visibility:public"])

platform(
    name = "rbe_platform",
    parents = ["@local_config_platform//:host"],
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "@bazel_tools//tools/cpp:clang",
    ],
    exec_properties = {
        # Buildbuddy guarantees they pre-cache this image.
        "container-image": "docker://gcr.io/flame-public/executor-docker-default:latest",
        #"container-image": "docker://l.gcr.io/google/rbe-ubuntu16-04@sha256:f6568d8168b14aafd1b707019927a63c2d37113a03bcee188218f99bd0327ea1",
        "OSFamily": "Linux",
    },
)
