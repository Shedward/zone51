QT       -= gui

TARGET = Platform
TEMPLATE = lib
CONFIG += staticlib

LIBS += -lglfw -lm -lGL -lGLU  -lGLEW

HEADERS += \
    platform.h

SOURCES += \
    platform.cpp
