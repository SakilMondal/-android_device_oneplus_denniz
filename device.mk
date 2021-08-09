#
# Copyright (C) 2020 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/oneplus/denniz

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 30

PRODUCT_SHIPPING_API_LEVEL := 30

# Call proprietary blob setup
$(call inherit-product-if-exists, vendor/oneplus/denniz/denniz-vendor.mk)

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Alert slider
PRODUCT_PACKAGES += \
    oplus-alert-slider

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor_overlay/etc/fstab.mt6893:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6893

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.denniz \
	vendor.oplus.hardware.biometrics.fingerprint@2.1

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhardware \
    libhwbinder

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Init
PRODUCT_PACKAGES += \
    init.mt6893.rc

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.denniz

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-aosp

# MTK IMS Overlays
PRODUCT_PACKAGES += \
    mtk-ims \
    mtk-ims-telephony

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    RcsService \
    PresencePolling

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# System prop
-include $(DEVICE_PATH)/system_prop.mk
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Vendor overlay
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/vendor_overlay/,$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/30/)

# Wi-Fi
PRODUCT_PACKAGES += \
    TetheringConfigOverlay \
    WifiOverlay

# IMS
$(call inherit-product-if-exists, vendor/mediatek/ims/packages/Android.mk)

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml
