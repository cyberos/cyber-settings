#include "about.h"

About::About(QObject *parent)
    : QObject(parent)
{
}

QString About::osName()
{
    return QSysInfo::prettyProductName();
}

QString About::osVersion()
{
    return QSysInfo::productVersion();
}

QString About::hostname()
{
    return QSysInfo::machineHostName();
}

QString About::userName()
{
    QByteArray userName = qgetenv("USER");

    if (userName.isEmpty())
        userName = qgetenv("USERNAME");

    return QString::fromUtf8(userName);
}

QString About::settingsVersion()
{
    return QObject::tr(SETTINGS_VERSION);
}

QString About::contributors()
{
    return QString("omame (omaemae) - Settings/About page.");
}

QString About::developers()
{
    return QString("Flex Zhong (ChungZH)\n"
                   "Felix Yan (felixonmars)\n"
                   "omame (omaemae)\n"
                   "probonopd\n"
                   "Reven Martin (rekols)");
}
