package k8spspreadonlyrootfilesystem

import data.lib.exempt_container.is_exempt

violation[{"msg": msg, "details": {}}] {
    c := input_containers[_]
    ns := input.review.object.metadata.namespace
    not is_exempt(c, ns)
    input_read_only_root_fs(c)
    msg := sprintf("only read-only root filesystem container is allowed: %v", [c.name])
}

input_read_only_root_fs(c) {
    not has_field(c, "securityContext")
}
input_read_only_root_fs(c) {
    not c.securityContext.readOnlyRootFilesystem == true
}

input_containers[c] {
    c := input.review.object.spec.containers[_]
}
input_containers[c] {
    c := input.review.object.spec.initContainers[_]
}
input_containers[c] {
    c := input.review.object.spec.ephemeralContainers[_]
}

# has_field returns whether an object has a field
has_field(object, field) = true {
    object[field]
}
