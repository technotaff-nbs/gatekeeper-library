package k8spspprivileged

import data.lib.exempt_container.is_exempt

violation[{"msg": msg, "details": {}}] {
    c := input_containers[_]
    ns := input.review.object.metadata.namespace
    not is_exempt(c, ns)
    c.securityContext.privileged
    msg := sprintf("Privileged container is not allowed: %v, securityContext: %v", [c.name, c.securityContext])
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
