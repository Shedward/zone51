CONFIG += link_pkgconfig

PKGCONFIG += gl

LIBS += -lglut -lGLEW -lGLU

SOURCES += \
    main.cpp

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../GLTools/release/ -lGLTools
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../GLTools/debug/ -lGLTools
else:unix: LIBS += -L$$OUT_PWD/../GLTools/ -lGLTools

INCLUDEPATH += $$PWD/../GLTools
DEPENDPATH += $$PWD/../GLTools

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../GLTools/release/libGLTools.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../GLTools/debug/libGLTools.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../GLTools/release/GLTools.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../GLTools/debug/GLTools.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../GLTools/libGLTools.a
