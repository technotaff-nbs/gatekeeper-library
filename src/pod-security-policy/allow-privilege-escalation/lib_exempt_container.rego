package lib.exempt_container

is_exempt(container, namespace) {
    exempt_images := object.get(object.get(input, "parameters", {}), "exemptImages", [])
    img := container.image
    exemption := exempt_images[_]
    namespace == exemption.namespace
    _matches_exemption(img, exemption.image)
}

_matches_exemption(img, image) {
    not endswith(image, "*")
    image == img
}

_matches_exemption(img, image) {
    endswith(image, "*")
    prefix := trim_suffix(image, "*")
    startswith(img, prefix)
}