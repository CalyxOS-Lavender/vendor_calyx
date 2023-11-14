PRODUCT_VERSION_MAJOR := 6
PRODUCT_VERSION_MINOR := 8
PRODUCT_VERSION_PATCH := 21
PRODUCT_VERSION_EXTRA :=

ifneq ($(OFFICIAL_BUILD),true)
PRODUCT_VERSION_EXTRA += -UNOFFICIAL
endif

CALYXOS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_PATCH)$(strip $(PRODUCT_VERSION_EXTRA))

PRODUCT_PRODUCT_PROPERTIES += \
    ro.calyxos.version=$(CALYXOS_VERSION)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/calyx/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/calyx/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/calyx/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/calyx/signing/keys/otakey.x509.pem
endif
endif

# BUILD_NUMBER
# See $top/calyx/scripts/release/version.sh
# last 2 of year,    yy * 1000000
# PRODUCT_VERSION_MAJOR * 100000
# PRODUCT_VERSION_MINOR * 1000
# PRODUCT_VERSION_PATCH * 10
# Last digit reserved
# Examples:
# 6.0.0 -> 24600000, otatest 24600001
# 6.0.1 -> 24600010
# 6.1.0 -> 24601000
# 6.10.10 -> 24610100
