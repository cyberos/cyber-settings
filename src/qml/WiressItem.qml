import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import MeuiKit 1.0 as Meui
import Cyber.NetworkManager 1.0 as NM

Item {
    id: control

    property bool passwordIsStatic: (model.securityType === NM.NetworkModelItem.StaticWep || model.securityType === NM.NetworkModelItem.WpaPsk ||
                                     model.securityType === NM.NetworkModelItem.Wpa2Psk || model.securityType === NM.NetworkModelItem.SAE)
    property bool predictableWirelessPassword: !model.uuid && model.type === NM.NetworkModelItem.Wireless && passwordIsStatic

    signal infoButtonClicked()

    Rectangle {
        anchors.fill: parent
        radius: Meui.Theme.smallRadius
        color: mouseArea.containsMouse ? Qt.rgba(Meui.Theme.textColor.r,
                                                 Meui.Theme.textColor.g,
                                                 Meui.Theme.textColor.b,
                                                 0.1) : "transparent"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton

        onClicked: {
            if (uuid || !predictableWirelessPassword) {
                if (connectionState === NM.NetworkModelItem.Deactivated) {
                    if (!predictableWirelessPassword && !uuid) {
                        networking.addAndActivateConnection(model.connectionPath, model.specificPath);
                    } else {
                        networking.activateConnection(model.connectionPath, model.devicePath, model.specificPath);
                    }
                } else {
                    networking.deactivateConnection(model.connectionPath, model.devicePath);
                }
            } else if (predictableWirelessPassword) {

            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: Meui.Units.smallSpacing
        spacing: Meui.Units.largeSpacing

        Image {
            width: 22
            height: width
            sourceSize: Qt.size(width, height)
            source: "qrc:/images/" + (Meui.Theme.darkMode ? "dark/" : "light/") + model.connectionIcon + ".svg"
        }

        Label {
            text: model.itemUniqueName
        }

        Item {
            Layout.fillWidth: true
        }

        // Locked
        Image {
            width: 16
            height: width
            sourceSize: Qt.size(width, height)
            source: "qrc:/images/locked.svg"
            visible: model.securityType !== -1 && model.securityType !== 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: Meui.Theme.textColor
                opacity: 1
                visible: true
            }
        }

        Image {
            id: busyIndicator
            width: 22
            height: width
            source: "qrc:/images/view-refresh.svg"
            sourceSize: Qt.size(width, height)
            visible: connectionState === NM.NetworkModelItem.Activating ||
                     connectionState === NM.NetworkModelItem.Deactivating

            ColorOverlay {
                anchors.fill: busyIndicator
                source: busyIndicator
                color: Meui.Theme.textColor
                opacity: 1
                visible: true
            }

            RotationAnimator {
                target: busyIndicator
                running: busyIndicator.visible
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 1000
            }
        }

        // Activated
        Image {
            width: 16
            height: width
            sourceSize: Qt.size(width, height)
            source: "qrc:/images/checked.svg"
            visible: model.connectionState === 2

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: Meui.Theme.highlightColor
                opacity: 1
                visible: true
            }
        }

        IconButton {
            source: "qrc:/images/info.svg"
            onClicked: control.infoButtonClicked()
        }
    }
}
