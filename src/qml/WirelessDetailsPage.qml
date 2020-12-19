import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import MeuiKit 1.0 as Meui

ItemPage {
    id: control

    property var model
    property var settingsMap: ({})

    canGoBack: true

    function loadSettings() {
//        if (settingsMap.hasOwnProperty("autoconnect"))
//            autoJoinSwitch.checked = settingsMap["autoconnect"]
//        else
//            autoJoinSwitch.checked = true
    }

    function load(model) {
        control.headerTitle = model.name
        securityLabel.text = model.securityTypeString
        ipv4AddressLabel.text = model.ipV4Address
        ipV6AddressLabel.text = model.ipV6Address
        macAddressLabel.text = model.macAddress
        routerLabel.text = model.gateway
        dnsLabel.text = model.nameServer

        control.model = model

        loadSettings()
    }

    function updateSettings() {
        settingsMap = {"connection": {}, "802-11-wireless": {}};
        settingsMap["connection"]["autoconnect"] = autoJoinSwitch.checked
        networkSettings.saveSettings(model.connectionPath, "connection", settingsMap["connection"])
        networkSettings.saveSettings(model.connectionPath, "802-11-wireless", settingsMap["802-11-wireless"])
    }

    Scrollable {
        id: scrollable
        anchors.fill: parent
        contentHeight: mainLayout.implicitHeight

        GridLayout {
            id: mainLayout

            columns: 2
            columnSpacing: Meui.Units.largeSpacing * 2

//            Label {
//                text: qsTr("Auto-Join")
//                Layout.alignment: Qt.AlignRight
//            }

//            Switch {
//                id: autoJoinSwitch
//                leftPadding: 0
//                Layout.fillHeight: true
//                onCheckedChanged: updateSettings()
//            }

            Label {
                font.bold: true
                text: qsTr("Security")

                Layout.alignment: Qt.AlignRight
            }

            Label {
                id: securityLabel
            }

            Label {
                font.bold: true
                text: qsTr("IPv4 Address")

                Layout.alignment: Qt.AlignRight
            }

            Label {
                id: ipv4AddressLabel
            }

            Label {
                font.bold: true
                text: qsTr("IPv6 Address")

                Layout.alignment: Qt.AlignRight
            }

            Label {
                id: ipV6AddressLabel
            }

            Label {
                font.bold: true
                text: qsTr("MAC Address")

                Layout.alignment: Qt.AlignRight
            }

            Label {
                id: macAddressLabel
            }

            Label {
                font.bold: true
                text: qsTr("Router")

                Layout.alignment: Qt.AlignRight
            }

            Label {
                id: routerLabel
            }

            Label {
                font.bold: true
                text: qsTr("DNS")

                Layout.alignment: Qt.AlignRight
            }

            Label {
                id: dnsLabel
            }
        }
    }
}
