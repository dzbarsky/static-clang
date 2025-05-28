def file(name, location):
    return "%s uid=0 gid=0 time=1672560000 mode=0755 type=file content=$(location %s)" % (name, location)

def link(name, target):
    return "%s uid=0 gid=0 time=1672560000 mode=0755 type=link link=%s" % (name, target)

def empty(name):
    return link(name, "empty")

def mtree(name, contents, outs, srcs = [], format={}):
    cmd = """\
cat <<EOF > $(@)
{lines}
EOF
""".format(lines = "\n".join(contents).format(**format))

    native.genrule(
        name = name,
        srcs = srcs,
        cmd = cmd,
        outs = outs,
    )