# Copyright (C) 2017 Marvell International Ltd.
# All Rights Reserved.


BOARD_NAME = $(basename $(notdir $(BOARD_FILE)))

FW_MAJOR_NUM := 1
FW_MINOR_NUM := 0
AIRPURIFIER_FW_VERSION := $(FW_MAJOR_NUM).$(FW_MINOR_NUM)

# Revision version number in firmware revision
#FW_REV_NUM :=
ifneq ($(FW_REV_NUM),)
	AIRPURIFIER_FW_VERSION := $(AIRPURIFIER_FW_VERSION).$(FW_REV_NUM)
endif

prj_name := hap_smart_AIRPURIFIER-$(AIRPURIFIER_FW_VERSION)

exec-y += $(prj_name)

# Info in firmware revision
#FW_VER_INFO :=
ifneq ($(FW_VER_INFO),)
	AIRPURIFIER_FW_VERSION := $(AIRPURIFIER_FW_VERSION)\;$(FW_VER_INFO)
endif

AIRPURIFIER_FW_VERSION := \"$(AIRPURIFIER_FW_VERSION)\"

$(prj_name)-objs-y := \
		src/main.c \
		src/smart_origins.c \
		src/event_handler.c
		# src/$(BOARD_NAME)/smart_switch_board.c \

$(prj_name)-cflags-y := -DAPP_FW_VERSION=$(AIRPURIFIER_FW_VERSION) -I$(d)/src

ifeq ($(BUILD_MODE),debug)
$(prj_name)-cflags-y += -DAPPCONFIG_DEBUG_ENABLE
endif

$(prj_name)-supported-toolchain-y := arm_gcc iar
