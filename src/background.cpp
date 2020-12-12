#include "background.h"
#include <QtConcurrent>

static QVariantList getBackgroundPaths()
{
    QVariantList list;
    QDirIterator it("/usr/share/backgrounds", QStringList() << "*.jpg" << "*.png", QDir::Files, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString bg = it.next();
        list.append(QVariant(bg));
    }
    return list;
}

Background::Background(QObject *parent)
    : QObject(parent)
{

}

QVariantList Background::backgrounds()
{
    QFuture<QVariantList> future = QtConcurrent::run(&getBackgroundPaths);
    QVariantList list = future.result();
    return list;
}

QString Background::currentBackgroundPath()
{
    QDBusInterface iface("org.cyber.Settings",
                         "/Theme",
                         "org.cyber.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        return iface.property("wallpaper").toString();
    }
    return QString();
}

void Background::setBackground(QString path)
{
    QDBusInterface iface("org.cyber.Settings",
                         "/Theme",
                         "org.cyber.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setWallpaper", path);
        emit backgroundChanged();
    }
}
