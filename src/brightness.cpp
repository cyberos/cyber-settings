#include "brightness.h"
#include <QDebug>

Brightness::Brightness(QObject *parent)
    : QObject(parent)
    , m_dbusConnection(QDBusConnection::sessionBus())
    , m_iface("org.cyber.settings",
              "/Brightness",
              "org.cyber.Brightness", m_dbusConnection)
    , m_value(0)
{
    if (!m_iface.isValid())
        return;

    m_value = m_iface.property("brightness").toInt();
}

void Brightness::setValue(int value)
{
    m_iface.call("setValue", value);
}

int Brightness::value() const
{
    return m_value;
}
