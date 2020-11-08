#include "appearance.h"

#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusReply>
#include <QDBusServiceWatcher>
#include <QDBusPendingCall>

Appearance::Appearance(QObject *parent)
    : QObject(parent)
    , m_dockSettings(new QSettings(QSettings::UserScope, "cyberos", "dock"))
    , m_dockConfigWacher(new QFileSystemWatcher(this))
    , m_dockIconSize(0)
    , m_dockDirection(0)
{
    m_dockIconSize = m_dockSettings->value("IconSize").toInt();
    m_dockDirection = m_dockSettings->value("Direction").toInt();

    m_dockConfigWacher->addPath(m_dockSettings->fileName());
    connect(m_dockConfigWacher, &QFileSystemWatcher::fileChanged, this, [=] {
        m_dockSettings->sync();
        m_dockIconSize = m_dockSettings->value("IconSize").toInt();
        m_dockDirection = m_dockSettings->value("Direction").toInt();
        m_dockConfigWacher->addPath(m_dockSettings->fileName());
        emit dockIconSizeChanged();
        emit dockDirectionChanged();
    });
}

void Appearance::switchDarkMode(bool darkMode)
{
    QDBusInterface iface("org.cyber.settings",
                         "/Theme",
                         "org.cyber.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setDarkMode", darkMode);
    }
}

int Appearance::dockIconSize() const
{
    return m_dockIconSize;
}

void Appearance::setDockIconSize(int dockIconSize)
{
    if (m_dockIconSize == dockIconSize)
        return;

    m_dockIconSize = dockIconSize;
    m_dockSettings->setValue("IconSize", m_dockIconSize);
}

int Appearance::dockDirection() const
{
    return m_dockDirection;
}

void Appearance::setDockDirection(int dockDirection)
{
    if (m_dockDirection == dockDirection)
        return;

    m_dockDirection = dockDirection;
    m_dockSettings->setValue("Direction", m_dockDirection);
}
