#include "about.h"

About::About(QObject *parent) :
    QObject(parent)
{
}

QString About::osName() {
    return QSysInfo::prettyProductName();
}

QString About::osVersion() {
    return QSysInfo::productVersion();
}

QString About::hostname() {
    return QSysInfo::machineHostName();
}

QString About::settingsVersion() {
    return QObject::tr(SETTINGS_VERSION);
}
