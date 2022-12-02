package k8spspallowprivilegeescalationcontainer

import data.lib.exempt_container.is_exempt

violation[{"msg": msg, "details": {}}] {
    c := input_containers[_]
    ns := input.review.object.metadata.namespace
    not is_exempt(c, ns)
    input_allow_privilege_escalation(c)
    msg := sprintf("Privilege escalation container image is not allowed: '%v' in namespace '%v'", [c.image, ns])
}

input_allow_privilege_escalation(c) {
    not has_field(c, "securityContext")
}
input_allow_privilege_escalation(c) {
    not c.securityContext.allowPrivilegeEscalation == false
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
