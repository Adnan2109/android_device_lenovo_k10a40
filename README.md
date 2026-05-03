# TWRP Device Tree — Lenovo Vibe C2 (k10a40)

## Device Info
| Key | Value |
|-----|-------|
| Model | Lenovo Vibe C2 (K10a40) |
| SoC | MediaTek MT6735M |
| CPU | Quad-core Cortex-A53, **32-bit** |
| Android | 6.0 Marshmallow |
| Display | 5.0" 720×1280 (~294 ppi) |
| Filesystem | EXT4 |
| Storage | eMMC |
| Crypto | None (unencrypted) |
| Display density | 294 dpi |

## Port Source
Ported from `android_device_motorola_taido` (Moto E3 Power — same MT6735M SoC, same display).
Key difference: **taido is 64-bit**, k10a40 is **32-bit only** (MT6735M variant).
Architecture was forced to pure `arm` / `armv7-a-neon` — no 64-bit second arch.

---

## Directory Structure

Place this tree at: `device/lenovo/k10a40/`

```
k10a40/
├── Android.mk
├── AndroidProducts.mk
├── BoardConfig.mk
├── device.mk
├── omni_k10a40.mk
├── omni.dependencies
├── recovery.fstab
├── vendorsetup.sh
├── prebuilt/
│   └── zImage              
└── recovery/
    └── root/
        ├── init.rc
        ├── init.recovery.mt6735.rc
        ├── enableswap.sh
        ├── fstab.mt6735
        ├── factory_init.rc
        ├── factory_init.project.rc
        ├── factory_init.usb.rc
        ├── meta_init.rc
        ├── meta_init.modem.rc
        ├── meta_init.project.rc
        ├── ueventd.mt6735.rc
        └── verity_key
```

---

## Build

```bash
# Clone TWRP minimal manifest (android-9.0 recommended for MT6735)
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-9.0
repo sync -j$(nproc)

# Place this tree at device/lenovo/k10a40/

source build/envsetup.sh
lunch omni_k10a40-eng
mka recoveryimage
```

Output: `out/target/product/k10a40/recovery.img`

---

## Flashing via fastboot
```bash
fastboot flash recovery out/target/product/k10a40/recovery.img
fastboot reboot recovery
```
