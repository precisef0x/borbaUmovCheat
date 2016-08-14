GO_EASY_ON_ME = 1
TARGET_IPHONEOS_DEPLOYMENT_VERSION=7.0
export SDKVERSION=9.3
export THEOS_DEVICE_PORT=22
export THEOS_DEVICE_IP=172.20.10.1

include theos/makefiles/common.mk

TWEAK_NAME = BorbaUmovCheat
BorbaUmovCheat_FILES = main.xm
BorbaUmovCheat_FRAMEWORKS = UIKit CoreGraphics
ARCHS = armv7 arm64
BorbaUmovCheat_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Russia"
