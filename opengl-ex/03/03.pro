TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

CONFIG += link_pkgconfig

PKGCONFIG += gl

SOURCES += main.cpp
LIBS += -lglut -lgltools -lGLEW
LIBS += -LC:\glut
