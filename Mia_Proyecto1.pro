TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
    lex.yy.c

DISTFILES += \
    generator.bat

HEADERS += \
    Lexicon.l
