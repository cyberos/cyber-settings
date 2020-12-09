import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui
import org.cyber.Settings 1.0

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
                text: qsTr("Cyber")
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

            GridLayout {
                rows: 3
                columns: 2

                columnSpacing: Meui.Units.largeSpacing * 2
                rowSpacing: Meui.Units.smallSpacing / 2

                Label {
                    text: qsTr("Operating System")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: about.osName
                }

                Label {
                    text: qsTr("Version")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: about.osVersion
                }

                Label {
                    text: qsTr("Username")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: about.userName
                }

                Label {
                    text: qsTr("Hostname")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: about.hostname
                }
            }

            // Cyber Info
            Label {
                text: qsTr("Cyber Info")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing * 2
                bottomPadding: Meui.Units.smallSpacing
            }

            GridLayout {
                rows: 2
                columns: 2

                columnSpacing: Meui.Units.largeSpacing * 2
                rowSpacing: Meui.Units.smallSpacing / 2

                Label {
                    text: qsTr("Cyber Settings Build")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: about.settingsVersion
                }

                Label {
                    text: qsTr("Cyber Developers")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: qsTr("Flex Zhong (ChungZH)\nFelix Yan (felixonmars)\nReven Martin (rekols)")
                }

                Label {
                    text: qsTr("Cyber Contributors")
                    color: Meui.Theme.disabledTextColor
                }
                Label {
                    text: qsTr("omame (omaemae) - Settings/About page.")
                }
            }
        }
    }
}
