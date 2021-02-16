import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui
import Cyber.Settings 1.0

ItemPage {
    headerTitle: qsTr("About")

    About {
        id: about
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent

            Image {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                width: 128
                height: width
                sourceSize: Qt.size(width, height)
                source: "qrc:/images/cyber-logo.svg"
            }

            Label {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                text: qsTr("CyberOS")
                font.pointSize: 24
                font.bold: true
                bottomPadding: Meui.Units.largeSpacing * 2
                leftPadding: Meui.Units.largeSpacing * 2
                rightPadding: Meui.Units.largeSpacing * 2
            }

            // OS
            Label {
                text: qsTr("OS Info")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            StandardItem {
                key: qsTr("Operating System")
                value: about.osName
            }

            StandardItem {
                key: qsTr("Kernel Version")
                value: about.kernelVersion
            }

            StandardItem {
                key: qsTr("RAM Size")
                value: about.memorySize
            }

            StandardItem {
                key: qsTr("Username")
                value: about.userName
            }

            StandardItem {
                key: qsTr("Hostname")
                value: about.hostname
            }

            HorizontalDivider {}

            Label {
                text: qsTr("CyberOS Team")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            StandardItem {
                key: "Flex Zhong"
                value: "@ChungZH"
            }

            StandardItem {
                key: "Felix Yan"
                value: "@felixonmars"
            }

            StandardItem {
                key: "omame"
                value: "@omaemae"
            }

            StandardItem {
                key: "Simon Peter"
                value: "@probonopd"
            }

            StandardItem {
                key: "Reven Martin"
                value: "@rekols"
            }

            StandardItem {
                key: "小子"
                value: "@Z-bin"
            }

            HorizontalDivider {}

            Label {
                text: qsTr("CyberOS Translators")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            StandardItem {
                key: qsTr("Polish")
                value: "omame (@omaemae)"
            }

            StandardItem {
                key: qsTr("Simplified Chinese")
                value: "Reven Martin (@rekols)"
            }

            StandardItem {
                key: qsTr("Spanish")
                value: "Sebastián (@Sebastian-byte)"
            }
        }
    }
}
