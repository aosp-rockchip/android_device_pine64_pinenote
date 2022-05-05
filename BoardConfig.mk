#
# Copyright 2014 The Android Open-Source Project
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
-include device/pine64/pinenote-kernel/BoardConfigKernel.mk
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a55
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

TARGET_BOARD_PLATFORM_PRODUCT := tablet

PRODUCT_UBOOT_CONFIG := rk3566-eink
PRODUCT_KERNEL_DTS := rk3566-rk817-eink-pinenote
PRODUCT_KERNEL_ARCH := arm64
PRODUCT_FSTAB_TEMPLATE := device/pine64/pinenote/fstab_eink.in

BUILD_EMULATOR := false
TARGET_BOARD_PLATFORM := rk356x
TARGET_BOARD_PLATFORM_GPU := mali-G52
TARGET_RK_GRALLOC_VERSION := 4
BOARD_USE_DRM := true

# RenderScript
BOARD_OVERRIDE_RS_CPU_VARIANT_32 := cortex-a55
BOARD_OVERRIDE_RS_CPU_VARIANT_64 := cortex-a55

TARGET_USES_64_BIT_BCMDHD := true
TARGET_USES_64_BIT_BINDER := true

# Sensors
BOARD_SENSOR_ST := true
BOARD_SENSOR_MPU_VR := false
BOARD_SENSOR_MPU_PAD := false
BOARD_USES_GENERIC_INVENSENSE := false

ENABLE_CPUSETS := true

# Enable Dex compile opt as default
WITH_DEXPREOPT := true

BOARD_USB_HOST_SUPPORT := true
ROCKCHIP_USE_LAZY_HAL := true
BOARD_GRAVITY_SENSOR_SUPPORT := true
BOARD_COMPASS_SENSOR_SUPPORT := false
BOARD_GYROSCOPE_SENSOR_SUPPORT := false
BOARD_PROXIMITY_SENSOR_SUPPORT := false
BOARD_LIGHT_SENSOR_SUPPORT := false
BOARD_PRESSURE_SENSOR_SUPPORT := false
BOARD_TEMPERATURE_SENSOR_SUPPORT := false
BOARD_GSENSOR_MXC6655XA_SUPPORT := true
BOARD_CAMERA_SUPPORT := false
BOARD_CAMERA_SUPPORT_EXT := false
BOARD_HAVE_FLASH := false
BUILD_WITH_FACELOCK := false
BOARD_NFC_SUPPORT := false
BOARD_HAS_RK_4G_MODEM := false
BOARD_HAS_GPS := false
CAMERA_SUPPORT_AUTOFOCUS := false
BOARD_USB_ACCESSORY_SUPPORT := false
BOARD_SUPPORT_HDMI := false
BUILD_WITH_CDROM := false
BOARD_HS_ETHERNET := false
BOARD_IS_SUPPORT_NTFS := false
BOARD_SHOW_HDMI_SETTING := false
BUILD_WITH_GO_OPT := false


BOARD_SUPPORT_VP9 := true
BOARD_SUPPORT_VP6 := false
BOARD_SUPPORT_HEVC_ENC := true

# Allow deprecated BUILD_ module types to get DDK building
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true

# for dynamaic afbc target 
BOARD_HS_DYNAMIC_AFBC_TARGET := false

# AB image definition
BOARD_USES_AB_IMAGE := false
BOARD_ROCKCHIP_VIRTUAL_AB_ENABLE := false
BOARD_USE_SPARSE_SYSTEM_IMAGE := true

#Config RK EBOOK
BUILD_WITH_RK_EBOOK := true
SF_PRIMARY_DISPLAY_ORIENTATION := 90

PRODUCT_HAVE_OPTEE := false

# Add widevine L3 support
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
