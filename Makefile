include theos/makefiles/common.mk

TWEAK_NAME = BrickDate
BrickDate_FILES = Tweak.xm
BrickDate_FRAMEWORKS = UIKit
export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:7.0:7.0
ADDITIONAL_CCFLAGS  = -Qunused-arguments
ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000
include $(THEOS_MAKE_PATH)/tweak.mk


