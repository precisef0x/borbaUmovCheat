GO_EASY_ON_ME = 1
TARGET_IPHONEOS_DEPLOYMENT_VERSION=7.0
export SDKVERSION=9.1
export THEOS_DEVICE_PORT=322
export THEOS_DEVICE_IP=192.168.20.1
#export THEOS_DEVICE_IP=192.168.20.8    #iPad
#export THEOS_DEVICE_IP=192.168.20.12    #iPod
#export THEOS_DEVICE_IP=192.168.1.8
#export THEOS_DEVICE_IP=192.168.1.128

include theos/makefiles/common.mk

TWEAK_NAME = BorbaUmovCheat
BorbaUmovCheat_FILES = Tweak.xm
BorbaUmovCheat_FRAMEWORKS = UIKit CoreGraphics
ARCHS = armv7 armv7s arm64
BorbaUmovCheat_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Russia"
