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
            title: qsTr("General")
        }

        ListElement {
            title: qsTr("Display")
        }

        ListElement {
            title: qsTr("Appearance")
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
            leftMargin: 10
            topMargin: topMargin
            rightMargin: 10
            bottomMargin: 10
        }

        Label {
            text: qsTr("Settings")
            font.bold: true
            font.pointSize: 18
            leftPadding: 10
            Layout.alignment: Qt.AlignTop
        }

        Item {
            height: 5
        }

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: listModel

            ScrollBar.vertical: ScrollBar {}

            delegate: Item {
                id: item
                implicitWidth: listView.width
                implicitHeight: 48 + itemRadiusV

                property bool isCurrent: listView.currentIndex === index

                Rectangle {
                    anchors {
                        fill: parent
                        topMargin: itemRadiusV
                        bottomMargin: itemRadiusV
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton
                        onClicked: listView.currentIndex = index
                    }

                    radius: itemRadiusV
                    color: isCurrent ? Meui.Theme.highlightColor : mouseArea.containsMouse ? Qt.rgba(0, 0, 0, 0.08) : "transparent"
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10

                    Label {
                        id: itemTitle
                        text: model.title
                        color: isCurrent ? Meui.Theme.highlightedTextColor : Meui.Theme.textColor
                    }
                }
            }
        }
    }
}
