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

_matches_exemption(target, exemption) {
    exemption == ""
}

_matches_exemption(target, exemption) {
    not endswith(exemption, "*")
    exemption == target
}

_matches_exemption(target, exemption) {
    endswith(exemption, "*")
    prefix := trim_suffix(exemption, "*")
    startswith(target, prefix)
}