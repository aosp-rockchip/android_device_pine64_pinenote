DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_KERNEL_CONFIG += rk356x_eink.config

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/eink_logo/poweroff_logo/poweroff.png:$(TARGET_COPY_OUT_VENDOR)/media/poweroff.png \
    $(LOCAL_PATH)/eink_logo/poweroff_logo/poweroff_nopower.png:$(TARGET_COPY_OUT_VENDOR)/media/poweroff_nopower.png \
    $(LOCAL_PATH)/eink_logo/standby_logo/standby.png:$(TARGET_COPY_OUT_VENDOR)/media/standby.png \
    $(LOCAL_PATH)/eink_logo/standby_logo/standby_lowpower.png:$(TARGET_COPY_OUT_VENDOR)/media/standby_lowpower.png \
    $(LOCAL_PATH)/eink_logo/standby_logo/standby_charge.png:$(TARGET_COPY_OUT_VENDOR)/media/standby_charge.png \
    $(LOCAL_PATH)/eink_logo/android_logo/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip \
    $(LOCAL_PATH)/configs/android.software.eink.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.eink.xml

# Apps
PRODUCT_PACKAGES += \
    NoNavigationBarModeGestural \
    EinkSystemUI

PRODUCT_PACKAGES += \
    displayd \
    libion

BOARD_SEPOLICY_DIRS += vendor/rockchip/hardware/interfaces/neuralnetworks/1.0/default/sepolicy
PRODUCT_PACKAGES += \
    public.libraries-rockchip \
    librknnhal_bridge.rockchip \
    rockchip.hardware.neuralnetworks@1.0-impl \
    rockchip.hardware.neuralnetworks@1.0-service

$(call inherit-product-if-exists, vendor/rockchip/common/npu/npu.mk)

BOARD_SEPOLICY_DIRS += device/pine64/pinenote/sepolicy_vendor
TARGET_SYSTEM_PROP += device/pine64/pinenote/pinenote.prop

# enable this for support f2fs with data partion
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# used for fstab_generator, sdmmc controller address
PRODUCT_BOOT_DEVICE := fe310000.sdhci,fe330000.nandc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.recovery.rk30board.rc:recovery/root/init.recovery.rk30board.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.pinenote.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rk356x.rc \
    $(LOCAL_PATH)/configs/media_profiles_default.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml\

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

# Use vulkan backend for hwui
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.renderer=skiavk

# copy xml files for Vulkan features.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_0_3.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2019-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level-2019-03-01.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level-2020-03-01.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

PRODUCT_PROPERTY_OVERRIDES += \
				ro.sf.lcd_density=320 \
                ro.vendor.eink=true \
                sys.eink.mode=7 \
                sys.eink.rgba2y4_by_rga=1 \
                persist.sys.idle-wakeup=false \
                persist.sys.idle-delay=5000 \
                sys.eink.recovery.eink_fb=true \
                ro.ril.ecclist=112,911 \
                ro.opengles.version=196610 \
                wifi.interface=wlan0 \
                ro.audio.monitorOrientation=true \
                debug.nfc.fw_download=false \
                debug.nfc.se=false \
                vendor.hwc.compose_policy=1 \
                sys.wallpaper.rgb565=0 \
                sf.power.control=2073600 \
                sys.rkadb.root=0 \
                ro.sf.fakerotation=false \
                ro.tether.denied=false \
                sys.resolution.changed=false \
                ro.default.size=100 \
                ro.product.usbfactory=rockchip_usb \
                wifi.supplicant_scan_interval=15 \
                ro.factory.tool=0 \
                ro.kernel.android.checkjni=0 \
                ro.build.shutdown_timeout=6 \
                persist.enable_task_snapshots=false 
                vendor.gralloc.disable_afbc=0 \
                dalvik.vm.foreground-heap-growth-multiplier=2.0 \
                sys.use_fifo_ui=1
