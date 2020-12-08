import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui
import org.cyber.Settings 1.0

ItemPage {
    headerTitle: qsTr("Battery")

    Battery {
        id: battery

        Component.onCompleted: {
            batteryBackground.value = battery.chargePercent
        }
    }

    Connections {
        target: battery

        function onChargePercentChanged(value) {
            batteryBackground.value = battery.chargePercent
        }
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight
        visible: battery.available

        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: Meui.Units.largeSpacing

            // Battery Info
            BatteryItem {
                id: batteryBackground
                Layout.fillWidth: true
                height: 150

                ColumnLayout {
                    anchors.fill: parent
                    anchors.leftMargin: batteryBackground.radius

                    Item {
                        Layout.fillHeight: true
                    }

                    RowLayout {
                        Label {
                            id: percentLabel
                            text: battery.chargePercent + "%"
                            color: "white"
                            font.pointSize: 40
                        }

                        Image {
                            id: sensorsVoltage
                            width: 30
                            height: width
                            sourceSize: Qt.size(width, height)
                            source: "qrc:/images/sensors-voltage-symbolic.svg"
                            visible: !battery.onBattery
                        }
                    }

                    Label {
                        text: battery.statusString
                        color: "white"
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            Item {
                height: Meui.Units.smallSpacing
            }

            StandardItem {
                key: qsTr("Last Charged to")
                value: battery.lastChargedPercent + "%"
                visible: battery.lastChargedPercent !== 0
            }

            StandardItem {
                key: qsTr("Maximum Capacity")
                value: battery.capacity + "%"
            }
        }
    }

    Label {
        anchors.centerIn: parent
        text: qsTr("No battery found")
        visible: !battery.available
    }
}
