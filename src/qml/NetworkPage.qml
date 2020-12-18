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
                                source: "image://icontheme/" + model.connectionIcon
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
                                if (model.connectionState === NM.NetworkModelItem.Deactivated) {
                                    if (!model.uuid && model.type === NM.NetworkModelItem.Wireless &&
                                                    (model.securityType === NM.NetworkModelItem.StaticWep ||
                                                     model.securityType === NM.NetworkModelItem.WpaPsk ||
                                                     model.securityType === NM.NetworkModelItem.Wpa2Psk)) {
                                        // OPEN

                                        console.log("!!!!")
                                    } else if (model.uuid) {
                                        networking.activateConnection(model.connectionPath, model.devicePath, model.specificPath);
                                    } else {
                                        networking.addAndActivateConnection(model.devicePath, model.specificPath);
                                    }
                                } else {
                                    networking.deactivateConnection(model.connectionPath, model.devicePath);
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
                                source: "image://icontheme/" + model.connectionIcon

                                onSourceChanged: {
                                    console.log(model.connectionIcon)
                                }
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
