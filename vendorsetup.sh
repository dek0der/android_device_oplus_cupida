#!/bin/bash

echo ""
echo "Starting device bringup by cloning respective trees"
echo ""

# common dt
#git clone https://github.com/subhagamer/android_device_oplus_mt6893-common -b rising-14 device/oplus/mt6893-common
git clone https://github.com/oplus-ossi-development/android_device_oplus_mt6893-common device/oplus/mt6893-common
echo ""

# proprietary_vendor
git clone https://github.com/oplus-ossi-development/proprietary_vendor_oplus_mt6893-common vendor/oplus/mt6893-common
echo ""

# hardware gnss
#git clone https://github.com/oplus-ossi-development/android_hardware_mediatek_gnss hardware/mediatek/gnss

# prebuilt apps
#git clone https://github.com/oplus-ossi-development/android_packages_apps_prebuilt-apps packages/apps/prebuilt-apps

# oneplus parts
git clone https://github.com/oplus-ossi-development/android_packages_apps_OneplusParts packages/apps/OneplusParts
echo ""

# kernel dt
git clone --depth=1 --recurse-submodules https://github.com/dek0der/kernel_realme_RMX3031 -b T kernel/oplus/mt6893
echo ""

# mediatek hardware
#git clone https://github.com/subhagamer/android_hardware_mediatek hardware/mediatek
rm -rf hardware/mediatek && git clone https://github.com/oplus-ossi-development/android_hardware_mediatek hardware/mediatek
echo ""

# hardware mediatek wlan
git clone https://github.com/oplus-ossi-development/android_hardware_mediatek_wlan hardware/mediatek/wlan
echo ""

# vendor oplus cupida
git clone https://github.com/oplus-ossi-development/proprietary_vendor_oplus_cupida vendor/oplus/cupida
echo ""

# sepolicy vndr
rm -rf device/mediatek/sepolicy_vndr && git clone https://github.com/oplus-ossi-development/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
echo ""

# oplus hardware
rm -rf hardware/oplus && git clone https://github.com/LineageOS/android_hardware_oplus -b lineage-21 hardware/oplus
echo ""

# Oplus camera
CAM=device/oplus/camera/camera.mk
if ! [ -a $CAM ]; then
    git clone https://gitlab.com/nattolecats/android_device_oplus_camera device/oplus/camera
fi
echo ""

cd device/oplus/camera/ && git lfs pull && cd ../../../
echo ""

# Clang
CLANG17=prebuilts/clang/host/linux-x86/clang-r487747/bin/clang
if ! [ -a $CLANG17 ]; then
    git clone https://gitlab.com/nattolecats/android_prebuilts_clang_host_linux-x86_clang-r487747 prebuilts/clang/host/linux-x86/clang-r487747 --depth 1
fi
echo ""

# Bypass API modified validations
export DISABLE_STUB_VALIDATION=true

#apply patch
bash device/oplus/mt6893-common/patches/apply.sh

#end cloning
echo "Bringup successful"
echo ""

#delete setup
mv device/oplus/cupida/vendorsetup.sh device/oplus/cupida/vendorsetup.sh.bak
mv device/oplus/mt6893-common/vendorsetup.sh device/oplus/mt6893-common/vendorsetup.sh.bak
