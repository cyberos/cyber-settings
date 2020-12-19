import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import MeuiKit 1.0 as Meui
import Cyber.NetworkManager 1.0 as NM

ItemPage {
    id: control
    headerTitle: qsTr("Network")

    property var itemHeight: 50

    NM.Networking {
        id: networking
    }

    NM.NetworkModel {
        id: networkModel
    }

    NM.NetworkSettings {
        id: networkSettings
    }

    Component.onCompleted: {
        wirelessSwitch.checked = networking.wirelessEnabled
    }

    Scrollable {
        anchors.fill: parent

        contentHeight: mainLayout.implicitHeight

        ColumnLayout {
            id: mainLayout
            anchors.fill: parent

            // Wired connection
            ColumnLayout {
                id: wiredLayout

                visible: networking.enabled && wiredView.count > 0

                RowLayout {
                    Label {
                        text: "Wired"
                        color: Meui.Theme.disabledTextColor
                        Layout.fillWidth: true
                    }
                }

                ListView {
                    id: wiredView

                    Layout.fillWidth: true
                    implicitHeight: wiredView.count * control.itemHeight
                    clip: true

                    model: NM.TechnologyProxyModel {
                        type: NM.TechnologyProxyModel.WiredType
                        sourceModel: networkModel
                    }

                    ScrollBar.vertical: ScrollBar {}

                    delegate: Item {
                        id: item
                        height: control.itemHeight
                        width: wiredView.width

                        RowLayout {
                            anchors.fill: parent
                            spacing: Meui.Units.largeSpacing

                            Image {
                                width: 16
                                height: width
                                sourceSize: Qt.size(width, height)
                                source: "qrc:/images/" + (Meui.Theme.darkMode ? "dark/" : "light/") + "network-wired.svg"
                            }

                            Label {
                                text: model.itemUniqueName
                                Layout.fillWidth: true
                            }

                            Label {
                                text: model.connectionStateString
                                color: Meui.Theme.disabledTextColor
                            }
                        }
                    }
                }
            }

            HorizontalDivider {
                visible: wiredView.visible && wirelessView.visible
            }

            // Wireless
            ColumnLayout {
                id: wirelessLayout

                RowLayout {
                    Label {
                        text: "Wireless"
                        color: Meui.Theme.disabledTextColor
                        Layout.fillWidth: true
                    }

                    Switch {
                        id: wirelessSwitch
                        Layout.fillHeight: true
                        onCheckedChanged: networking.wirelessEnabled = checked
                    }
                }

                ListView {
                    id: wirelessView

                    visible: networking.wirelessEnabled && networking.wirelessHardwareEnabled
                    Layout.fillWidth: true

                    implicitHeight: count * control.itemHeight
                    interactive: false
                    clip: true

                    model: NM.TechnologyProxyModel {
                        type: NM.TechnologyProxyModel.WirelessType
                        sourceModel: networkModel
                        showInactiveConnections: true
                    }

                    ScrollBar.vertical: ScrollBar {}

                    delegate: Item {
                        height: control.itemHeight
                        width: wirelessView.width

                        property bool passwordIsStatic: (model.securityType === NM.NetworkModelItem.StaticWep || model.securityType === NM.NetworkModelItem.WpaPsk ||
                                                         model.securityType === NM.NetworkModelItem.Wpa2Psk || model.securityType === NM.NetworkModelItem.SAE)
                        property bool predictableWirelessPassword: !model.uuid && model.type === NM.NetworkModelItem.Wireless && passwordIsStatic

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton

                            onClicked: {
                                if (uuid || !predictableWirelessPassword) {
                                    if (connectionState === NM.NetworkModelItem.Deactivated) {
                                        if (!predictableWirelessPassword && !uuid) {
                                            networking.addAndActivateConnection(model.connectionPath, model.specificPath);
                                        } else {
                                            networking.activateConnection(model.connectionPath, model.devicePath, model.specificPath);
                                        }
                                    } else {
                                        networking.deactivateConnection(model.connectionPath, model.devicePath);
                                    }
                                } else if (predictableWirelessPassword) {
                                }
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            spacing: Meui.Units.largeSpacing

                            Image {
                                width: 16
                                height: width
                                sourceSize: Qt.size(width, height)
                                source: "qrc:/images/" + (Meui.Theme.darkMode ? "dark/" : "light/") + model.connectionIcon + ".svg"
                            }

                            Label {
                                text: model.itemUniqueName
                            }

                            // Locked
                            Image {
                                width: 16
                                height: width
                                sourceSize: Qt.size(width, height)
                                source: "qrc:/images/locked.svg"
                                visible: model.securityType !== -1 && model.securityType !== 0

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: Meui.Theme.textColor
                                    opacity: 1
                                    visible: true
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                            }

                            Image {
                                id: busyIndicator
                                width: 22
                                height: width
                                source: "qrc:/images/view-refresh.svg"
                                sourceSize: Qt.size(width, height)
                                visible: connectionState === NM.NetworkModelItem.Activating ||
                                         connectionState === NM.NetworkModelItem.Deactivating

                                ColorOverlay {
                                    anchors.fill: busyIndicator
                                    source: busyIndicator
                                    color: Meui.Theme.textColor
                                    opacity: 1
                                    visible: true
                                }

                                RotationAnimator {
                                    target: busyIndicator
                                    running: busyIndicator.visible
                                    from: 0
                                    to: 360
                                    loops: Animation.Infinite
                                    duration: 1000
                                }
                            }

                            // Activated
                            Image {
                                width: 16
                                height: width
                                sourceSize: Qt.size(width, height)
                                source: "qrc:/images/checked.svg"
                                visible: model.connectionState === 2

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: Meui.Theme.highlightColor
                                    opacity: 1
                                    visible: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
