/*
    Copyright (C) 2019 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
    Copyright 2013-2018 Jan Grulich <jgrulich@redhat.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef PLASMA_NM_MODEL_NETWORK_MODEL_ITEM_H
#define PLASMA_NM_MODEL_NETWORK_MODEL_ITEM_H

#include <NetworkManagerQt/ActiveConnection>
#include <NetworkManagerQt/Connection>
#include <NetworkManagerQt/ConnectionSettings>
#include <NetworkManagerQt/Device>
#include <NetworkManagerQt/Utils>

#include "networkmodel.h"

class Q_DECL_EXPORT NetworkModelItem : public QObject
{
    Q_OBJECT
public:
    enum ConnectionType {
        Unknown = 0,
        Adsl,
        Bluetooth,
        Bond,
        Bridge,
        Cdma,
        Gsm,
        Infiniband,
        OLPCMesh,
        Pppoe,
        Vlan,
        Vpn,
        Wimax,
        Wired,
        Wireless,
        Team,
        Generic,
        Tun,
        IpTunnel
    };
    Q_ENUM(ConnectionType)

    enum SecurityType {
        UnknownSecurity = -1,
        NoneSecurity = 0,
        StaticWep,
        DynamicWep,
        Leap,
        WpaPsk,
        WpaEap,
        Wpa2Psk,
        Wpa2Eap
    };
    Q_ENUM(SecurityType)

    enum ItemType {
        UnavailableConnection,
        AvailableConnection,
        AvailableAccessPoint
    };
    Q_ENUM(ItemType)

    enum State {
        isUnknown = 0, /**< The active connection is in an unknown state */
        Activating, /**< The connection is activating */
        Activated, /**< The connection is activated */
        Deactivating, /**< The connection is being torn down and cleaned up */
        Deactivated /**< The connection is no longer active */
    };
    Q_ENUM(State)

    explicit NetworkModelItem(QObject *parent = nullptr);
    explicit NetworkModelItem(const NetworkModelItem *item, QObject *parent = nullptr);
    ~NetworkModelItem() override;

    QString activeConnectionPath() const;
    void setActiveConnectionPath(const QString &path);

    QString connectionPath() const;
    void setConnectionPath(const QString &path);

    NetworkManager::ActiveConnection::State connectionState() const;
    void setConnectionState(NetworkManager::ActiveConnection::State state);

    QString connectionStateString() const;

    QStringList details() const;

    QString deviceName() const;
    void setDeviceName(const QString &name);

    QString devicePath() const;
    void setDevicePath(const QString &path);

    QString deviceState() const;
    void setDeviceState(const NetworkManager::Device::State state);

    bool duplicate() const;

    QString icon() const;

    ItemType itemType() const;

    NetworkManager::WirelessSetting::NetworkMode mode() const;
    void setMode(const NetworkManager::WirelessSetting::NetworkMode mode);

    QString name() const;
    void setName(const QString &name);

    QString originalName() const;

    QString sectionType() const;

    NetworkManager::WirelessSecurityType securityType() const;
    void setSecurityType(NetworkManager::WirelessSecurityType type);

    int signal() const;
    void setSignal(int signal);

    QString signalStrength() const;

    bool slave() const;
    void setSlave(bool slave);

    QString specificPath() const;
    void setSpecificPath(const QString &path);

    QString ssid() const;
    void setSsid(const QString &ssid);

    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &date);

    NetworkManager::ConnectionSettings::ConnectionType type() const;
    void setType(NetworkManager::ConnectionSettings::ConnectionType type);

    QString uni() const;

    QString uuid() const;
    void setUuid(const QString &uuid);

    QString vpnState() const;
    void setVpnState(NetworkManager::VpnConnection::State state);

    QString vpnType() const;
    void setVpnType(const QString &type);

    qulonglong rxBytes() const;
    void setRxBytes(qulonglong bytes);

    qulonglong txBytes() const;
    void setTxBytes(qulonglong bytes);

    QString linkSpeed() const;

    QString ipV4Address() const;
    QString ipV6Address() const;

    QString gateway() const;

    QString nameServer() const;

    QString macAddress() const;

    bool operator==(const NetworkModelItem *item) const;

public Q_SLOTS:
    void invalidateDetails();

private:
    void updateDetails() const;

    QString m_activeConnectionPath;
    QString m_connectionPath;
    NetworkManager::ActiveConnection::State m_connectionState;
    QString m_devicePath;
    QString m_deviceName;
    NetworkManager::Device::State m_deviceState;
    mutable QStringList m_details;
    mutable bool m_detailsValid;
    bool m_duplicate;
    NetworkManager::WirelessSetting::NetworkMode m_mode;
    QString m_name;
    NetworkManager::WirelessSecurityType m_securityType;
    int m_signal;
    bool m_slave;
    QString m_specificPath;
    QString m_ssid;
    QDateTime m_timestamp;
    NetworkManager::ConnectionSettings::ConnectionType m_type;
    QString m_uuid;
    QString m_vpnType;
    NetworkManager::VpnConnection::State m_vpnState;
    qulonglong m_rxBytes;
    qulonglong m_txBytes;
};

#endif // PLASMA_NM_MODEL_NETWORK_MODEL_ITEM_H
