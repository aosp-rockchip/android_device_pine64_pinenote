#
# Copyright 2014 Rockchip Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include vendor/rockchip/common/BoardConfigVendor.mk

BOARD_VENDOR_GPU_PLATFORM := bifrost

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Normal tablet, add QuickStep for normal product only.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
PRODUCT_PACKAGES += Launcher3QuickStep

PRODUCT_AAPT_CONFIG ?= normal large xlarge hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG ?= xhdpi



########################################################
# Kernel
########################################################
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel

#SDK Version
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rksdk.version=RK30_ANDROID$(PLATFORM_VERSION)-SDK-v1.00.00

# Filesystem management tools
PRODUCT_PACKAGES += \
    fsck.f2fs \
    mkfs.f2fs \
    fsck_f2fs

PRODUCT_PACKAGES += \
    vndservicemanager

# omx
PRODUCT_PACKAGES += \
    libomxvpu_enc \
    libomxvpu_dec \
    libRkOMX_Resourcemanager \
    libOMX_Core \

# For screen hwrotation
ifneq ($(filter 90 180 270, $(strip $(SF_PRIMARY_DISPLAY_ORIENTATION))), )
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	ro.surface_flinger.primary_display_orientation=ORIENTATION_$(SF_PRIMARY_DISPLAY_ORIENTATION)
endif

PRODUCT_DEX_PREOPT_GENERATE_DM_FILES := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify
# Configure jemalloc for low memory 
MALLOC_SVELTE := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.rockchip.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rockchip.rc \
    $(LOCAL_PATH)/init.mount_all_early.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mount_all.rc \
    $(LOCAL_PATH)/init.connectivity.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.connectivity.rc \
    $(LOCAL_PATH)/init.insmod.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.cfg \
    $(LOCAL_PATH)/init.insmod.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.insmod.sh \
    $(LOCAL_PATH)/init.$(TARGET_BOARD_HARDWARE).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_BOARD_HARDWARE).rc \
    $(LOCAL_PATH)/init.$(TARGET_BOARD_HARDWARE).usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_BOARD_HARDWARE).usb.rc \
    $(LOCAL_PATH)/ueventd.rockchip.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(LOCAL_PATH)/alarm_filter.xml:system/etc/alarm_filter.xml \

PRODUCT_COPY_FILES += \
    hardware/rockchip/libgraphicpolicy/graphic_profiles.conf:$(TARGET_COPY_OUT_VENDOR)/etc/graphic/graphic_profiles.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wpa_config.txt:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_config.txt \
    hardware/broadcom/wlan/bcmdhd/config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    hardware/broadcom/wlan/bcmdhd/config/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    hardware/realtek/wlan/supplicant_overlay_config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_rtk.conf \
    hardware/realtek/wlan/supplicant_overlay_config/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_rtk.conf

#for ssv6051
PRODUCT_COPY_FILES += \
    vendor/rockchip/common/wifi/ssv6xxx/p2p_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_ssv.conf \

PRODUCT_PACKAGES += \
    iperf \
    libiconv \
    libwpa_client \
    hostapd \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_cli \
    wpa_supplicant.conf \
    dhcpcd.conf

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service-lazy

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio_policy_volumes_drc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes_drc.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

# For audio-recoard 
PRODUCT_PACKAGES += \
    libsrec_jni

# For tts test
PRODUCT_PACKAGES += \
    libwebrtc_audio_coding

#audio
$(call inherit-product-if-exists, hardware/rockchip/audio/tinyalsa_hal/codec_config/rk_audio.mk)

# SDCardFS deprecate
# https://source.android.google.cn/devices/storage/sdcardfs-deprecate
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml

# USB HOST
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# USB ACCESSORY
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.vr=0

# Sensor HAL
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl \
    sensors.$(TARGET_BOARD_HARDWARE)

# Power AIDL
PRODUCT_PACKAGES += \
    android.hardware.power \
    android.hardware.power-service.rockchip

# Camera omx-plugin vpu akmd libion_rockchip_ext
PRODUCT_PACKAGES += \
    libvpu \
    libstagefrighthw \
    libgralloc_priv_omx \
    akmd \
    libion_ext


# Light AIDL
PRODUCT_PACKAGES += \
    android.hardware.lights \
    android.hardware.lights-service.rockchip

# Fastbootd HAL
# TODO: develop a hal for GMS...
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-rockchip \
    fastbootd

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.mpp_buf_type=1
# Gralloc HAL
PRODUCT_PACKAGES += \
    arm.graphics-V1-ndk_platform.so \
    android.hardware.graphics.allocator@4.0-impl-$(BOARD_VENDOR_GPU_PLATFORM) \
    android.hardware.graphics.mapper@4.0-impl-$(BOARD_VENDOR_GPU_PLATFORM) \
    android.hardware.graphics.allocator@4.0-service

DEVICE_MANIFEST_FILE += \
    device/pine64/pinenote/manifests/android.hardware.graphics.mapper@4.0.xml \
    device/pine64/pinenote/manifests/android.hardware.graphics.allocator@4.0.xml

PRODUCT_PACKAGES += \
    rkhelper

# For EGL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.egl=${TARGET_BOARD_HARDWARE_EGL}

# HW Composer
PRODUCT_PACKAGES += \
    hwcomposer.$(TARGET_BOARD_HARDWARE) \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service

# iep
BUILD_IEP := true
PRODUCT_PACKAGES += \
    libiep

# charge
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Allows healthd to boot directly from charger mode rather than initiating a reboot.
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.enable_boot_charger_mode=0

# Add board.platform default property to parsing related rc
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.board.platform=$(strip $(TARGET_BOARD_PLATFORM)) \
    ro.target.product=$(strip $(TARGET_BOARD_PLATFORM_PRODUCT))

PRODUCT_CHARACTERISTICS := tablet

# audio lib
PRODUCT_PACKAGES += \
    audio_policy.$(TARGET_BOARD_HARDWARE) \
    audio.primary.$(TARGET_BOARD_HARDWARE) \
    audio.alsa_usb.$(TARGET_BOARD_HARDWARE) \
    audio.a2dp.default\
    audio.r_submix.default\
    libaudioroute\
    audio.usb.default

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl

PRODUCT_PACKAGES += \
    libclearkeycasplugin

PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service-lazy \
    android.hardware.drm@1.3-service-lazy.clearkey

PRODUCT_PACKAGES += \
    rockchip.hardware.rockit.hw@1.0-service \
    librockit_hw_client@1.0

#Health hardware
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl

# for swiftshader, vulkan v1.1 test.
PRODUCT_PACKAGES += \
  vulkan.rk30board

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cpuvulkan.version=4198400

PRODUCT_COPY_FILES += \
  frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
  frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-0.xml \
  frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
  frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Filesystem management tools
# EXT3/4 support
PRODUCT_PACKAGES += \
    mke2fs \
    e2fsck \
    tune2fs \
    resize2fs

# audio lib
PRODUCT_PACKAGES += \
    libasound \
    alsa.default \
    acoustics.default \
    libtinyalsa \
    tinymix \
    tinyplay \
    tinycap \
    tinypcminfo

PRODUCT_PACKAGES += \
	alsa.audio.primary.$(TARGET_BOARD_HARDWARE)\
	alsa.audio_policy.$(TARGET_BOARD_HARDWARE)

$(call inherit-product-if-exists, external/alsa-lib/copy.mk)
$(call inherit-product-if-exists, external/alsa-utils/copy.mk)


PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.strictmode.visual=false 

PRODUCT_PROPERTY_OVERRIDES += ro.rk.bt_enable=true

ifeq ($(strip $(MT6622_BT_SUPPORT)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.btchip=mt6622
endif

PRODUCT_PROPERTY_OVERRIDES += ro.rk.hdmi_enable=false
PRODUCT_PROPERTY_OVERRIDES += ro.rk.flash_enable=false

ifeq ($(strip $(MT7601U_WIFI_SUPPORT)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.wifichip=mt7601u
endif

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PROPERTY_OVERRIDES +=       \
    ro.factory.hasUMS=false         \
    testing.mediascanner.skiplist = /mnt/shell/emulated/Android/

PRODUCT_COPY_FILES += \
    device/pine64/pinenote/init.rockchip.hasUMS.false.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_BOARD_HARDWARE).environment.rc

PRODUCT_PACKAGES += rockchip.drmservice

PRODUCT_PROPERTY_OVERRIDES += \
    ro.factory.hasGPS=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.factory.storage_suppntfs=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.factory.without_battery=false
 
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Bluetooth HAL
PRODUCT_PACKAGES += \
    libbt-vendor \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth@1.0-service.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.rk.screenoff_time=60000

# Flash Lock Status reporting,
# GTS: com.google.android.gts.persistentdata.
# PersistentDataHostTest#testTestGetFlashLockState
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.oem_unlock_supported=1

PRODUCT_PACKAGES += \
    move_widevine_data.sh

PRODUCT_PACKAGES += \
    android.hardware.drm@1.3-service-lazy.widevine

$(call inherit-product-if-exists, vendor/rockchip/common/device-vendor.mk)

########################################################
# this product has support remotecontrol or not
########################################################
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.enable.remotecontrol=false

PRODUCT_PACKAGES += \
	abc

PRODUCT_PROPERTY_OVERRIDES += \
	ro.vendor.udisk.visible=true

#if disable safe mode to speed up booting time
PRODUCT_PROPERTY_OVERRIDES += \
    ro.safemode.disabled=true

#add for hwui property
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rk.screenshot_enable=true   \
    ro.rk.hdmi_enable=true   \
    sys.status.hidebar_enable=false

PRODUCT_FULL_TREBLE_OVERRIDE := true
#PRODUCT_COMPATIBILITY_MATRIX_LEVEL_OVERRIDE := 27

# Add runtime resource overlay for framework-res
PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

#The module which belong to vndk-sp is defined by google
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0.vndk-sp\
    android.hardware.graphics.allocator@2.0.vndk-sp\
    android.hardware.graphics.mapper@2.0.vndk-sp\
    android.hardware.graphics.common@1.0.vndk-sp\
    libhwbinder.vndk-sp\
    libbase.vndk-sp\
    libcutils.vndk-sp\
    libhardware.vndk-sp\
    libhidlbase.vndk-sp\
    libhidltransport.vndk-sp\
    libutils.vndk-sp\
    libc++.vndk-sp\
    libRS_internal.vndk-sp\
    libRSDriver.vndk-sp\
    libRSCpuRef.vndk-sp\
    libbcinfo.vndk-sp\
    libblas.vndk-sp\
    libft2.vndk-sp\
    libpng.vndk-sp\
    libcompiler_rt.vndk-sp\
    libbacktrace.vndk-sp\
    libunwind.vndk-sp\
    liblzma.vndk-sp

#######for target product ########
PRODUCT_PROPERTY_OVERRIDES += \
    ro.target.product=tablet

# By default, enable zram; experiment can toggle the flag,
# which takes effect on boot
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.zram_enabled=1

### fix adb-device cannot be identified  ###
### in AOSP-system image (user firmware) ###
ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.logd.kernel=1
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/zmodem/rz:$(TARGET_COPY_OUT_VENDOR)/bin/rz \
    $(LOCAL_PATH)/zmodem/sz:$(TARGET_COPY_OUT_VENDOR)/bin/sz \
    $(LOCAL_PATH)/picocom/bin/picocom:$(TARGET_COPY_OUT_VENDOR)/bin/picocom
PRODUCT_PACKAGES += io
endif

USE_XML_AUDIO_POLICY_CONF := 1

PRODUCT_PROPERTY_OVERRIDES += \
       ro.usb.default_mtp=true

PRODUCT_PACKAGES += libstdc++.vendor

#TWRP
BOARD_TWRP_ENABLE ?= false

# add AudioSetting
PRODUCT_PACKAGES += \
    rockchip.hardware.rkaudiosetting@1.0-service \
    rockchip.hardware.rkaudiosetting@1.0-impl \
    rockchip.hardware.rkaudiosetting@1.0

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rt_audio_config.xml:/system/etc/rt_audio_config.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rt_video_config.xml:/system/etc/rt_video_config.xml

#FLASH_IMG
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.flash_img.enable=false

# Vendor seccomp policy files for media components:
PRODUCT_COPY_FILES += \
    device/pine64/pinenote/seccomp_policy/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

#bt config for ap bt
PRODUCT_COPY_FILES += \
    $(TARGET_DEVICE_DIR)/bt_vendor.conf:/vendor/etc/bluetooth/bt_vendor.conf

# Rockchip HALs
$(call inherit-product, device/pine64/pinenote/manifests/frameworks/vintf.mk)
#for disable optee support
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service \
    android.hardware.gatekeeper@1.0-service.software

DEVICE_MANIFEST_FILE += device/pine64/pinenote/manifests/android.hardware.keymaster@4.0-service.xml
