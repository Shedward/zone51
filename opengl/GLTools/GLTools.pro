QT       -= gui

TARGET = GLTools
TEMPLATE = lib
CONFIG += staticlib

CONFIG += link_pkgconfig

PKGCONFIG += gl

LIBS += -lglut -lgltools -lGLEW -lGLU

unix {
    target.path = /usr/lib
    INSTALLS += target
}

HEADERS += \
    GLBatch.h \
    GLBatchBase.h \
    GLFrame.h \
    GLFrustum.h \
    GLGeometryTransform.h \
    GLMatrixStack.h \
    GLShaderManager.h \
    GLTools.h \
    GLTriangleBatch.h \
    math3d.h \
    StopWatch.h

SOURCES += \
    GLBatch.cpp \
    GLShaderManager.cpp \
    GLTools.cpp \
    GLTriangleBatch.cpp \
    math3d.cpp
