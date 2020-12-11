import QtQuick 2.4
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import MeuiKit 1.0 as Meui

Item {
    id: control
    height: 150

    property int value: 0
    property int radius: height * 0.15

    Rectangle {
        id: valueRect
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: Qt.rgba(57 / 255, 187 / 255, 94 / 255, 1)
        radius: control.radius
        width: control.width * (control.value / 100)

        Behavior on width {
            SmoothedAnimation {
                velocity: 1000
            }
        }
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        z: -1
        color: Qt.rgba(57 / 255, 187 / 255, 94 / 255, 1)
        opacity: 0.5
        radius: control.radius
    }
}
