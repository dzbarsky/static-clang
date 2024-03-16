def ll_library(
        name,
        compilation_mode = None,
        compile_flags = [],
        shared_object_link_flags = [],
        emit = [],
        srcs = [],
        hdrs = [],
        includes = [],
        angled_includes = [],
        exposed_angled_includes = [],
        exposed_hdrs = [],
        interfaces = [],
        exposed_interfaces = [],
        **kwargs):
    if emit and emit[0] == "shared-object":
        kwargs["linkshared"] = 1

    #print(includes)
    #for i, inc in enumerate(includes):
    #    if inc.startswith(name + "/"):
    #        includes[i] = inc[len(name) + 1:]
    #print(includes)

    #print(name, exposed_angled_includes, angled_includes, includes, exposed_hdrs)
    native.cc_library(
        name = name,
        srcs = srcs + [h for h in hdrs if h.endswith(".h")],
        hdrs = exposed_hdrs,
        #hdrs = [h for h in hdrs if h.endswith(".h")] + exposed_hdrs,
        textual_hdrs = [h for h in hdrs if not h.endswith(".h")],
        copts = compile_flags + ["-I%s" % i for i in includes if "$(GENERATED)" not in i],
        linkopts = shared_object_link_flags,
        includes = [i for i in exposed_angled_includes if "$(GENERATED)" not in i],
        **kwargs
    )
