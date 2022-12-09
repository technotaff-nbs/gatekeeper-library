package lib.exempt_container

is_exempt(container, namespace) {
    exempt_images := object.get(object.get(input, "parameters", {}), "exemptImages", [])
    img := container.image
    exemption := exempt_images[_]
    # empty namespace is ok, empty image is not
    exempt_namespace := object.get(exemption, "namespace", "")
    not exemption.image == ""
    _matches_exemption(img, exemption.image)
    _matches_exemption(namespace, exempt_namespace)
}

_matches_exemption(target, excemption) {
    excemption == ""
}

_matches_exemption(target, excemption) {
    not endswith(excemption, "*")
    excemption == target
}

_matches_exemption(target, excemption) {
    endswith(excemption, "*")
    prefix := trim_suffix(excemption, "*")
    startswith(target, prefix)
}