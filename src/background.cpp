#include "background.h"

Background::Background(QObject *parent)
    : QObject(parent)
{
}

// stub
QList<QVariant> Background::backgrounds() {
    QList<QVariant> list;
    list.append(QVariant(QString("/usr/share/backgrounds/gnome/SeaSunset.jpg")));
    return list;
}

QString Background::currentBackgroundPath() {
    QDBusInterface iface("org.cyber.Settings",
                         "/Theme",
                         "org.cyber.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        return iface.property("wallpaper").toString();
    }
    return NULL;
}

void Background::setBackground(QString path) {
    QDBusInterface iface("org.cyber.Settings",
                         "/Theme",
                         "org.cyber.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setWallpaper", path);
    }
    return;
}
