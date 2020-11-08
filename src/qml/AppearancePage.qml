import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui

ItemPage {
    headerTitle: qsTr("Appearance")

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.margins: 10
        flickableDirection: Flickable.VerticalFlick
        clip: true

        ColumnLayout {
            anchors.fill: parent

            Label {
                text: qsTr("Theme")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            RadioButton {
                checked: !Meui.Theme.darkMode
                text: qsTr("Light")
                onClicked: Appearance.switchDarkMode(false)
            }

            RadioButton {
                checked: Meui.Theme.darkMode
                text: qsTr("Dark")
                onClicked: Appearance.switchDarkMode(true)
            }

            // Dock
            Label {
                text: qsTr("Dock Direction")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            ColumnLayout {
                RadioButton {
                    checked: Appearance.dockDirection === 0
                    text: qsTr("Left")
                    onClicked: Appearance.setDockDirection(0)
                }

                RadioButton {
                    checked: Appearance.dockDirection === 1
                    text: qsTr("Bottom")
                    onClicked: Appearance.setDockDirection(1)
                }
            }

            Label {
                text: qsTr("Dock Icon Size")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            ComboBox {
                model: [ qsTr("Small"), qsTr("Medium"), qsTr("Large"), qsTr("Huge") ]
                Layout.fillWidth: true

                currentIndex: {
                    var index = 0

                    if (Appearance.dockIconSize <= 32)
                        index = 0
                    else if (Appearance.dockIconSize <= 48)
                        index = 1
                    else if (Appearance.dockIconSize <= 64)
                        index = 2
                    else if (Appearance.dockIconSize <= 88)
                        index = 3

                    return index
                }

                onCurrentIndexChanged: {
                    var iconSize = 0

                    switch (currentIndex) {
                    case 0:
                        iconSize = 32
                        break;
                    case 1:
                        iconSize = 48
                        break;
                    case 2:
                        iconSize = 64
                        break;
                    case 3:
                        iconSize = 88;
                        break;
                    }

                    Appearance.setDockIconSize(iconSize)
                }
            }

            // Font
            Label {
                text: qsTr("Font")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            // General font
            RowLayout {
                spacing: 10

                Label {
                    text: qsTr("General Font")
                    color: Meui.Theme.disabledTextColor
                    topPadding: Meui.Units.largeSpacing
                    bottomPadding: Meui.Units.smallSpacing
                }

                ComboBox {
                    id: generalFontBox
                    model: Qt.fontFamilies()
                    Layout.fillWidth: true
                }
            }


            Item {
                Layout.fillHeight: true
            }

        }
    }
}
