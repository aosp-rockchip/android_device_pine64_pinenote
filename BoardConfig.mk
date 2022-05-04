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
include device/rockchip/rk356x/BoardConfig.mk
-include device/pine64/pinenote-kernel/BoardConfigKernel.mk
BUILD_WITH_GO_OPT := false

# AB image definition
BOARD_USES_AB_IMAGE := false
BOARD_ROCKCHIP_VIRTUAL_AB_ENABLE := false

ifeq ($(strip $(BOARD_USES_AB_IMAGE)), true)
    include device/rockchip/common/BoardConfig_AB.mk
    TARGET_RECOVERY_FSTAB := device/rockchip/rk356x/rk3566_r/recovery.fstab_AB
endif
PRODUCT_UBOOT_CONFIG := rk3566-eink
PRODUCT_KERNEL_DTS := rk3566-rk817-eink-pinenote
PRODUCT_FSTAB_TEMPLATE := device/rockchip/rk356x/rk3566_eink/fstab_eink.in

BOARD_USE_LAZY_HAL := true
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

#Config RK EBOOK
BUILD_WITH_RK_EBOOK := true
SF_PRIMARY_DISPLAY_ORIENTATION := 90

PRODUCT_HAVE_OPTEE := false
