CONFIG += c++11

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Platform/release/ -lPlatform
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Platform/debug/ -lPlatform
else:unix: LIBS += -L$$OUT_PWD/../Platform/ -lPlatform

INCLUDEPATH += $$PWD/../Platform
DEPENDPATH += $$PWD/../Platform

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../Platform/release/libPlatform.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../Platform/debug/libPlatform.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../Platform/release/Platform.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../Platform/debug/Platform.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../Platform/libPlatform.a

LIBS += -lglfw -lm -lGL -lGLU  -lGLEW

SOURCES += \
    main.cpp
