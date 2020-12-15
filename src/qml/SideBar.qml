import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui

Item {
    implicitWidth: 260

    property int itemRadiusV: 8

    property alias currentIndex: listView.currentIndex

    ListModel {
        id: listModel

        ListElement {
            title: qsTr("Display")
        }

        ListElement {
            title: qsTr("Appearance")
        }

        ListElement {
            title: qsTr("Dock")
        }

        ListElement {
            title: qsTr("Wallpaper")
        }

        ListElement {
            title: qsTr("Battery")
        }

        ListElement {
            title: qsTr("About")
        }
    }

    ColumnLayout {
        anchors {
            fill: parent
            margins: Meui.Units.largeSpacing
        }

        Label {
            text: qsTr("Settings")
            font.bold: true
            font.pointSize: 18
            topPadding: 10
            leftPadding: 16
            Layout.alignment: Qt.AlignTop
        }

        Item {
            height: Meui.Units.smallSpacing
        }

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: listModel

            spacing: Meui.Units.largeSpacing

            ScrollBar.vertical: ScrollBar {}

            delegate: Item {
                id: item
                implicitWidth: listView.width
                implicitHeight: 48

                property bool isCurrent: listView.currentIndex === index

                Rectangle {
                    anchors.fill: parent

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton
                        onClicked: listView.currentIndex = index
                    }

                    radius: Meui.Theme.bigRadius
                    color: isCurrent ?
                        Meui.Theme.highlightColor
                        : mouseArea.containsMouse ?
                            Qt.rgba(Meui.Theme.textColor.r,
                                    Meui.Theme.textColor.g,
                                    Meui.Theme.textColor.b,
                                    0.1)
                            : "transparent"
                    smooth: true
                    Behavior on color {
                        ColorAnimation {
                            duration: 125
                        }
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 16

                    Label {
                        id: itemTitle
                        text: model.title
                        color: isCurrent ? Meui.Theme.highlightedTextColor : Meui.Theme.textColor
                        font.bold: isCurrent
                        Behavior on color {
                            ColorAnimation {
                                duration: 125
                            }
                        }
                    }
                }
            }
        }
    }
}
