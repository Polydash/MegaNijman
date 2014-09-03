TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
    Src/main.cpp \
    Src/App/SFMLApp.cpp

OTHER_FILES += \
    Makefile

HEADERS += \
    Src/App/SFMLApp.h \
    Src/Macros/Allocation.h

