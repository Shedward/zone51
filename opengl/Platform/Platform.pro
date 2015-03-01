QT       -= gui

TARGET = Platform
TEMPLATE = lib
CONFIG += staticlib

LIBS += -lglfw -lm -lGL -lGLU

HEADERS += \
    platform.h

SOURCES += \
    platform.cpp
