import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
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

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.width: 2
                border.color: Meui.Theme.highlightColor
                radius: Meui.Theme.bigRadius
                visible: control.checked
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
