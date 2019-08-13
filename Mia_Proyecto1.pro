TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
    Syntact.tab.c \
    lex.yy.c


DISTFILES += \
    generator.bat

HEADERS += \
    Lexicon.l \
    Syntact.tab.h \
    Syntact.y
