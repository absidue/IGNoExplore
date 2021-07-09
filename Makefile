ARCHS = arm64
TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = Instagram


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = IGNoExplore

IGNoExplore_FILES = Tweak.x
IGNoExplore_CFLAGS = -fobjc-arc
IGNoExplore_LOGOS_DEFAULT_GENERATOR = internal

after-install::
	install.exec 'uiopen instagram:'

include $(THEOS_MAKE_PATH)/tweak.mk
