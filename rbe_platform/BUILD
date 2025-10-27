package(default_visibility = ["//visibility:public"])

platform(
    name = "rbe_platform",
    #parents = ["@local_config_platform//:host"],
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        "@bazel_tools//tools/cpp:clang",
    ],
    exec_properties = {
        # Buildbuddy guarantees they pre-cache this image.
        "container-image": "docker://gcr.io/flame-public/rbe-ubuntu22-04:latest",
        #"container-image": "docker://l.gcr.io/google/rbe-ubuntu18-04@sha256:48b67b41118dbcdfc265e7335f454fbefa62681ab8d47200971fc7a52fb32054",
        "OSFamily": "Linux",
    },
)
