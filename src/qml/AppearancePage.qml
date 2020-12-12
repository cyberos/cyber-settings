import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import org.cyber.Settings 1.0
import MeuiKit 1.0 as Meui

ItemPage {
    headerTitle: qsTr("Appearance")

    FontsModel {
        id: fontsModel
    }

    Appearance {
        id: appearance
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent

            Label {
                text: qsTr("Theme")
                color: Meui.Theme.disabledTextColor
                bottomPadding: Meui.Units.smallSpacing
            }

            // Light Mode and Dark Mode
            Row {
                spacing: Meui.Units.largeSpacing * 2

                ColumnLayout {
                    Image {
                        id: lightModeImg
                        width: 128
                        height: width
                        sourceSize: Qt.size(width, height)
                        source: "qrc:/images/light_mode.svg"

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.width: 2
                            border.color: Meui.Theme.highlightColor
                            radius: Meui.Theme.bigRadius
                            visible: !Meui.Theme.darkMode
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            onClicked: appearance.switchDarkMode(false)
                        }
                    }

                    Label {
                        text: qsTr("Light")
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                ColumnLayout {
                    Image {
                        id: darkMode
                        width: 128
                        height: width
                        sourceSize: Qt.size(width, height)
                        source: "qrc:/images/dark_mode.svg"

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.width: 2
                            border.color: Meui.Theme.highlightColor
                            radius: Meui.Theme.bigRadius
                            visible: Meui.Theme.darkMode
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            onClicked: appearance.switchDarkMode(true)
                        }
                    }

                    Label {
                        text: qsTr("Dark")
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            RowLayout {
                spacing: Meui.Units.largeSpacing * 2

                Label {
                    id: dimsTipsLabel
                    text: qsTr("Dark Appearance Dims Wallpaper")
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                }


                Switch {
                    checked: appearance.dimsWallpaper
                    height: dimsTipsLabel.height
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    onCheckedChanged: appearance.setDimsWallpaper(checked)
                }
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
                    checked: appearance.dockDirection === 0
                    text: qsTr("Left")
                    onClicked: appearance.setDockDirection(0)
                    Layout.fillWidth: true
                }

                RadioButton {
                    checked: appearance.dockDirection === 1
                    text: qsTr("Bottom")
                    onClicked: appearance.setDockDirection(1)
                    Layout.fillWidth: true
                }
            }

            Label {
                text: qsTr("Dock Icon Size")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            TabBar {
                id: dockSizeTabbar
                Layout.fillWidth: true

                TabButton {
                    text: qsTr("Small")
                }

                TabButton {
                    text: qsTr("Medium")
                }

                TabButton {
                    text: qsTr("Large")
                }

                TabButton {
                    text: qsTr("Huge")
                }

                currentIndex: {
                    var index = 0

                    if (appearance.dockIconSize <= 48)
                        index = 0
                    else if (appearance.dockIconSize <= 64)
                        index = 1
                    else if (appearance.dockIconSize <= 88)
                        index = 2
                    else if (appearance.dockIconSize <= 128)
                        index = 3

                    return index
                }

                onCurrentIndexChanged: {
                    var iconSize = 0

                    switch (currentIndex) {
                    case 0:
                        iconSize = 48
                        break;
                    case 1:
                        iconSize = 64
                        break;
                    case 2:
                        iconSize = 88
                        break;
                    case 3:
                        iconSize = 128
                        break;
                    }

                    appearance.setDockIconSize(iconSize)
                }
            }

            // Font
            Label {
                text: qsTr("Font")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.smallSpacing
            }

            GridLayout {
                rows: 3
                columns: 2

                columnSpacing: Meui.Units.largeSpacing * 2

                Label {
                    text: qsTr("General Font")
                    color: Meui.Theme.disabledTextColor
                    topPadding: Meui.Units.largeSpacing
                    bottomPadding: Meui.Units.smallSpacing
                }

                ComboBox {
                    id: generalFontBox
                    model: fontsModel.generalFonts
                    currentIndex: fontsModel.generalFontIndex
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                    onActivated: appearance.setGenericFontFamily(currentText)
                }

                Label {
                    text: qsTr("Fixed Font")
                    color: Meui.Theme.disabledTextColor
                    topPadding: Meui.Units.largeSpacing
                    bottomPadding: Meui.Units.smallSpacing
                }

                ComboBox {
                    id: fixedFont
                    model: fontsModel.fixedFonts
                    currentIndex: fontsModel.fixedFontIndex
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                    onActivated: appearance.setFixedFontFamily(currentText)
                }

                Label {
                    text: qsTr("Font Size")
                    color: Meui.Theme.disabledTextColor
                    topPadding: Meui.Units.largeSpacing
                    bottomPadding: Meui.Units.smallSpacing
                }

                TabBar {
                    Layout.fillWidth: true

                    TabButton {
                        text: qsTr("Small")
                    }

                    TabButton {
                        text: qsTr("Medium")
                    }

                    TabButton {
                        text: qsTr("Large")
                    }

                    TabButton {
                        text: qsTr("Huge")
                    }

                    currentIndex: {
                        var index = 0

                        if (appearance.fontPointSize <= 11)
                            index = 0
                        else if (appearance.fontPointSize <= 13)
                            index = 1
                        else if (appearance.fontPointSize <= 15)
                            index = 2
                        else if (appearance.fontPointSize <= 18)
                            index = 3

                        return index
                    }

                    onCurrentIndexChanged: {
                        var fontSize = 0

                        switch (currentIndex) {
                        case 0:
                            fontSize = 11
                            break;
                        case 1:
                            fontSize = 13
                            break;
                        case 2:
                            fontSize = 15
                            break;
                        case 3:
                            fontSize = 18
                            break;
                        }

                        appearance.setFontPointSize(fontSize)
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
