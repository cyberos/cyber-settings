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
    property var settingsMap: ({})

    NM.Networking {
        id: networking
    }

    NM.NetworkModel {
        id: networkModel
    }

    NM.NetworkSettings {
        id: networkSettings
    }

    WirelessDetailsPage {
        id: wiressDetailsPage
        visible: false
        onBackClicked: {
            stackView.pop()
        }
    }

    Scrollable {
        id: homePage
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
                                width: 22
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
                        leftPadding: 0
                        rightPadding: 0
                        onCheckedChanged: networking.wirelessEnabled = checked
                    }

                    Component.onCompleted: {
                        wirelessSwitch.checked = networking.wirelessEnabled
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

                    delegate: WiressItem {
                        height: control.itemHeight
                        width: wirelessView.width

                        onInfoButtonClicked: {
                            wiressDetailsPage.settingsMap = {
                                "connection": {},
                                "802-11-wireless": {},
                            };

                            Object.keys(wiressDetailsPage.settingsMap).forEach(function(key) {
                                wiressDetailsPage.settingsMap[key] = networkSettings.getSettings(model.connectionPath, key)
                            })

                            wiressDetailsPage.load(model)
                            stackView.push(wiressDetailsPage)
                        }
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: homePage
    }
}
