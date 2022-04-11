#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, device/rockchip/rk356x/rk3566_eink/rk3566_eink.mk)


BOARD_HAVE_BLUETOOTH_RTK := false

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
