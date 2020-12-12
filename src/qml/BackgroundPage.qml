import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import org.cyber.Settings 1.0
import MeuiKit 1.0 as Meui

ItemPage {
    headerTitle: qsTr("Background")

    Background {
        id: background
    }

    GridView {
        anchors.fill: parent
        anchors.topMargin: Meui.Units.largeSpacing
        anchors.leftMargin: Meui.Units.largeSpacing
        anchors.rightMargin: Meui.Units.largeSpacing

        cellWidth: 200
        cellHeight: 180

        clip: true
        model: background.backgrounds

        currentIndex: -1

        delegate: Item {
            id: item

            required property variant modelData
            property bool isSelected: modelData === background.currentBackgroundPath

            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Rectangle {
                anchors.fill: parent
                anchors.leftMargin: Meui.Units.largeSpacing
                anchors.rightMargin: Meui.Units.largeSpacing
                anchors.topMargin: Meui.Units.smallSpacing
                anchors.bottomMargin: Meui.Units.smallSpacing
                radius: Meui.Theme.smallRadius

                border.color: Meui.Theme.highlightColor
                border.width: image.status == Image.Ready & isSelected ? 2 : 0

                Image {
                    id: image
                    anchors.fill: parent
                    anchors.margins: Meui.Theme.smallRadius
                    source: "file://" + modelData
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    mipmap: true
                    cache: false
                    opacity: 1.0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 125
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    hoverEnabled: true

                    onClicked: background.setBackground(item.modelData)

                    onEntered: function() {
                        parent.opacity = 0.7
                    }
                    onExited: function() {
                        parent.opacity = 1.0
                    }
                }
            }
        }
    }
}
