import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
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
            title: qsTr("Background")
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
            leftMargin: Meui.Units.largeSpacing
            topMargin: Meui.Units.largeSpacing
            rightMargin: Meui.Units.largeSpacing
            bottomMargin: Meui.Units.largeSpacing
        }

        Label {
            text: qsTr("Settings")
            font.bold: true
            font.pointSize: 18
            leftPadding: 10
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
                    color: isCurrent ? Qt.rgba(Meui.Theme.highlightColor.r,
                                                 Meui.Theme.highlightColor.g,
                                                 Meui.Theme.highlightColor.b,
                                                 0.1) : mouseArea.containsMouse ? Qt.rgba(Meui.Theme.textColor.r,
                                                                                                       Meui.Theme.textColor.g,
                                                                                                       Meui.Theme.textColor.b,
                                                                                                       0.1) : "transparent"
                    border.color: isCurrent ? Qt.rgba(Meui.Theme.highlightColor.r,
                                                        Meui.Theme.highlightColor.g,
                                                        Meui.Theme.highlightColor.b, 0.5) : "transparent"
                    border.width: isCurrent ? 1 : 0
                    smooth: true
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10

                    Label {
                        id: itemTitle
                        text: model.title
                        color: isCurrent ? Meui.Theme.highlightColor : Meui.Theme.textColor
                    }
                }
            }
        }
    }
}
