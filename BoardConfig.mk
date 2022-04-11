include device/rockchip/rk356x/rk3566_eink/BoardConfig.mk
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

BUILD_WITH_GO_OPT := true

DONT_UNCOMPRESS_PRIV_APPS_DEXS := false

# AB image definition
BOARD_USES_AB_IMAGE := false
BOARD_ROCKCHIP_VIRTUAL_AB_ENABLE := false

ifeq ($(strip $(BOARD_USES_AB_IMAGE)), true)
    include device/rockchip/common/BoardConfig_AB.mk
    TARGET_RECOVERY_FSTAB := device/rockchip/rk356x/rk3566_r/recovery.fstab_AB
endif
PRODUCT_UBOOT_CONFIG := rk3566-eink
PRODUCT_KERNEL_DTS := rk3566-rk817-eink-w103
PRODUCT_FSTAB_TEMPLATE := device/pine64/pinenote/fstab_eink.in

BOARD_GSENSOR_MXC6655XA_SUPPORT := true
BOARD_CAMERA_SUPPORT_EXT := true

BOARD_HAVE_BLUETOOTH_RTK := false
BOARD_CONNECTIVITY_VENDOR := Broadcom
SF_PRIMARY_DISPLAY_ORIENTATION := 270

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

TARGET_2ND_ARCH :=
TARGET_2ND_ARCH_VARIANT :=
TARGET_2ND_CPU_ABI :=
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT :=

PRODUCT_HAVE_OPTEE := false

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    DTC=$(shell pwd)/prebuilts/misc/$(HOST_OS)-x86/dtc/dtc \
    MKDTIMG=$(shell pwd)/prebuilts/misc/$(HOST_OS)-x86/libufdt/mkdtimg
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := rk3566_eink_defconfig
TARGET_KERNEL_SOURCE := kernel/rockchip/rk356x
