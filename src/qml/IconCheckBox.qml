import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import MeuiKit 1.0 as Meui

Item {
    id: control

    property var iconSpacing: Meui.Units.smallSpacing * 0.8
    property alias source: icon.source
    property alias text: label.text
    property bool checked: false

    signal clicked

    implicitHeight: mainLayout.implicitHeight
    implicitWidth: mainLayout.implicitWidth

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        Rectangle {
            id: _box
            width: 128
            height: width
            color: "transparent"
            border.width: 2
            border.color: control.checked ? Meui.Theme.highlightColor : "transparent"
            radius: Meui.Theme.bigRadius + control.iconSpacing
            visible: true

            Image {
                id: icon
                width: _box.width - control.iconSpacing * 2
                height: _box.height - control.iconSpacing * 2
                anchors.centerIn: parent
                sourceSize: Qt.size(icon.width, icon.height)

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
            }

//            Item {
//                anchors.fill: parent
//                anchors.margins: control.iconSpacing

//                Image {
//                    id: icon
//                    anchors.fill: parent
//                    sourceSize: Qt.size(icon.width + control.iconSpacing + 2, icon.height + control.iconSpacing + 2)

//                    layer.enabled: true
//                    layer.effect: OpacityMask {
//                        maskSource: Item {
//                            width: icon.width
//                            height: icon.height

//                            Rectangle {
//                                anchors.fill: parent
//                                radius: Meui.Theme.bigRadius
//                            }
//                        }
//                    }
//                }
//            }
        }

        Label {
            id: label
            color: control.checked ? Meui.Theme.highlightColor : Meui.Theme.textColor
            Layout.alignment: Qt.AlignHCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: control.clicked()
    }
}
