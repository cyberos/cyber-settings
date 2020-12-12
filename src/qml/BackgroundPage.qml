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

    Rectangle {
        anchors.fill: parent
        anchors.margins: Meui.Units.largeSpacing
        anchors.leftMargin: Meui.Units.largeSpacing * 2
        id: root
        color: "transparent"
        
        Label {
            id: curBgLabel
            text: qsTr("Current background")
            color: Meui.Theme.disabledTextColor
            anchors.top: root.top
            anchors.left: root.left
            anchors.topMargin: Meui.Units.smallSpacing
        }

        Image {
            id: currentBackgroundImage
            source: "file://" + background.currentBackgroundPath
            fillMode: Image.PreserveAspectCrop
            clip: true
            anchors.left: root.left
            anchors.right: root.right
            anchors.top: curBgLabel.bottom
            anchors.topMargin: Meui.Units.largeSpacing
            height: root.height - 200
            asynchronous: true
            mipmap: true
        }

        Label {
            id: availableBgLabel
            text: qsTr("Available backgrounds")
            color: Meui.Theme.disabledTextColor
            anchors.top: currentBackgroundImage.bottom
            anchors.left: root.left
            anchors.topMargin: Meui.Units.smallSpacing
        }

        ListView {
            id: listView
            height: 128
            anchors.top: availableBgLabel.bottom
            anchors.bottom: root.bottom
            anchors.left: root.left
            anchors.right: root.right
            anchors.topMargin: Meui.Units.largeSpacing
            orientation: ListView.Horizontal
            model: background.backgrounds
            clip: true
            spacing: Meui.Units.largeSpacing
            ScrollBar.vertical: ScrollBar {}
            delegate: Image {
                required property variant modelData
                fillMode: Image.PreserveAspectFit
                height: listView.height
                source: "file://" + modelData
                opacity: 1.0
                asynchronous: true
                Behavior on opacity {
                    NumberAnimation {
                        duration: 125
                        easing.type: Easing.InOutQuad
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    hoverEnabled: true
                    onClicked: function() {
                        console.log("Setting background: " + parent.modelData)
                        background.setBackground(parent.modelData)
                    }
                    onEntered: function() {
                        parent.opacity = 0.7
                    }
                    onExited: function() {
                        parent.opacity = 1.0
                    }
                }
                mipmap: true
            }
        }
    }
}
