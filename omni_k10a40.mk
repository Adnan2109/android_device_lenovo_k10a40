# Release name
PRODUCT_RELEASE_NAME := k10a40

# Inherit from OMNI
$(call inherit-product, vendor/omni/config/common.mk)

# Device-specific
$(call inherit-product, device/lenovo/k10a40/device.mk)

PRODUCT_DEVICE := k10a40
PRODUCT_NAME := omni_k10a40
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := Lenovo Vibe C2
PRODUCT_MANUFACTURER := LENOVO

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=k10a40 \
    BUILD_FINGERPRINT="Lenovo/k10a40/k10a40:6.0/MRA58K/k10a40:user/release-keys" \
    PRIVATE_BUILD_DESC="full_k10a40-user 6.0 MRA58K 1 release-keys"
