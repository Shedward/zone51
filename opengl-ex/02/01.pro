TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

CONFIG += link_pkgconfig

PKGCONFIG += gl

LIBS += -lglut -lgltools -lGLEW
LIBS += -LC:\glut

SOURCES += main.cpp
