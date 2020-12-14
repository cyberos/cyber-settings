import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import MeuiKit 1.0 as Meui

Item {
    id: control

    property alias source: icon.source
    property alias text: label.text
    property bool checked: false

    signal clicked

    implicitHeight: mainLayout.implicitHeight
    implicitWidth: mainLayout.implicitWidth

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        Image {
            id: icon
            width: 128
            height: width
            sourceSize: Qt.size(width, height)

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: icon.width
                    height: icon.height

                    Rectangle {
                        anchors.fill: parent
                        radius: Meui.Theme.bigRadius
                    }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.width: 2
                border.color: control.checked ? Meui.Theme.highlightColor : "transparent"
                radius: Meui.Theme.bigRadius
                visible: true
            }
        }

        Label {
            id: label
            Layout.alignment: Qt.AlignHCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: control.clicked()
    }
}
