TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt
CONFIG += c++11
QMAKE_CXXFLAGS += -pthread -std=c++11

LIBS += -pthread

SOURCES += main.cpp
