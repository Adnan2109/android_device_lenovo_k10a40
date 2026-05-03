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
│   └── zImage              ← YOU MUST supply this (see below)
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

## Pre-build steps

### 1. Get a prebuilt kernel (zImage)
You need a 32-bit zImage for MT6735M. Options:
- Extract from your stock recovery.img:
  ```bash
  abootimg -x recovery.img
  # This produces zImage and ramdisk.img
  cp zImage device/lenovo/k10a40/prebuilt/zImage
  ```
- Or extract from stock boot.img the same way.

### 2. Verify kernel offsets
The offsets in BoardConfig.mk are MT6735M defaults. Double-check them:
```bash
abootimg -i recovery.img
# Look for: kernel addr, ramdisk addr, tags addr, page size
```
If they differ, update `BOARD_KERNEL_BASE`, `BOARD_KERNEL_OFFSET`,
`BOARD_RAMDISK_OFFSET`, `BOARD_TAGS_OFFSET` in BoardConfig.mk.

### 3. Verify partition sizes
```bash
adb shell cat /proc/partitions
```
Update `BOARD_RECOVERYIMAGE_PARTITION_SIZE` if needed (build will error if wrong).

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

## Flashing

### SP Flash Tool (safest for MTK)
1. Open SP Flash Tool
2. Load your device's scatter file
3. Select only the `recovery` partition
4. Point to `recovery.img`
5. Click Download

### Via fastboot (if unlocked)
```bash
fastboot flash recovery out/target/product/k10a40/recovery.img
fastboot reboot recovery
```

---

## Porting notes / Things to verify

1. **Partition sizes** — the values in BoardConfig.mk are estimates. Run
   `adb shell cat /proc/partitions` on your device and update if needed.

2. **Display density** — set to 294 dpi (5" 720p). The original K10a40 tree
   used 320 dpi. Adjust `ro.sf.lcd_density` in `device.mk` if UI looks off.

3. **fstab** — copied from the K10a40 tree (same MT6735M block device paths).
   If your device has extra/missing partitions (e.g. no `metadata`), edit
   `recovery.fstab` accordingly.

4. **taido sepolicy** — not included; TWRP builds don't typically need it
   and the kernel cmdline already forces `androidboot.selinux=permissive`.

5. **taido overlay / configs** — not ported; those are for full Android builds,
   not TWRP recovery.

6. **init.rc** — taken from k10a40 original; taido's rootdir had no custom
   `init.rc` so no conflict.
