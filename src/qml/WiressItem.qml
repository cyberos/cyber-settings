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
                passwordDialog.open()
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

        IconButton {
            source: "qrc:/images/info.svg"
            onClicked: control.infoButtonClicked()
        }
    }

    Dialog {
        id: passwordDialog
        title: qsTr("Connect to Network")

        implicitWidth: 400
        height: 200
        modal: true

        x: (parent.width - width) / 2
        y: (parent.height - height) / 4

        onOpened: passwordField.forceActiveFocus()
        onAccepted: networking.addAndActivateConnection(model.devicePath, model.specificPath, passwordField.text)

        footer: DialogButtonBox {
            Button {
                text: qsTr("Connect")
                enabled: passwordField.acceptableInput
                flat: true

                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            }

            Button {
                text: qsTr("Cancel")
                flat: true

                DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
            }
        }

        ColumnLayout {
            width: parent.width

            TextField {
                id: passwordField
                focus: true
                echoMode: showPasswordCheckbox.checked ? TextInput.Normal : TextInput.Password
                placeholderText: qsTr("Password")
                validator: RegExpValidator {
                    regExp: {
                        if (model.securityType === NM.NetworkModelItem.StaticWep)
                            return /^(?:[\x20-\x7F]{5}|[0-9a-fA-F]{10}|[\x20-\x7F]{13}|[0-9a-fA-F]{26}){1}$/;
                        return /^(?:[\x20-\x7F]{8,64}){1}$/;
                    }
                }
                onAccepted: passwordDialog.accept()

                Layout.fillWidth: true
            }

            CheckBox {
                id: showPasswordCheckbox
                checked: false
                text: qsTr("Show password")
            }
        }
    }
}
