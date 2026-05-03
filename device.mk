LOCAL_PATH := device/lenovo/k10a40

# Recovery fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:recovery/root/etc/recovery.fstab

# Recovery root files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.rc:recovery/root/init.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6735.rc:recovery/root/init.recovery.mt6735.rc \
    $(LOCAL_PATH)/recovery/root/enableswap.sh:recovery/root/enableswap.sh \
    $(LOCAL_PATH)/recovery/root/fstab.mt6735:recovery/root/fstab.mt6735 \
    $(LOCAL_PATH)/recovery/root/factory_init.rc:recovery/root/factory_init.rc \
    $(LOCAL_PATH)/recovery/root/factory_init.project.rc:recovery/root/factory_init.project.rc \
    $(LOCAL_PATH)/recovery/root/factory_init.usb.rc:recovery/root/factory_init.usb.rc \
    $(LOCAL_PATH)/recovery/root/meta_init.rc:recovery/root/meta_init.rc \
    $(LOCAL_PATH)/recovery/root/meta_init.modem.rc:recovery/root/meta_init.modem.rc \
    $(LOCAL_PATH)/recovery/root/meta_init.project.rc:recovery/root/meta_init.project.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.mt6735.rc:recovery/root/ueventd.mt6735.rc \
    $(LOCAL_PATH)/recovery/root/verity_key:recovery/root/verity_key

# Properties — 32-bit zygote, correct display density for 5" 720p screen
PRODUCT_PROPERTY_OVERRIDES += \
    ro.zygote=zygote32 \
    ro.sf.lcd_density=294
