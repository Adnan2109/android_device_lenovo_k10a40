LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),k10a40)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
