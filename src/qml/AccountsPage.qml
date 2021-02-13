import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.15
import MeuiKit 1.0 as Meui
import Cyber.Settings 1.0
import Cyber.Accounts 1.0 as Accounts

ItemPage {
    headerTitle: qsTr("Accounts")

    Accounts.UserAccount {
        id: currentUser
    }

    Accounts.UsersModel {
        id: userModel
    }

    Accounts.AccountsManager {
        id: accountsManager
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent

            Label {
                text: qsTr("Currently logged in as")
                color: Meui.Theme.disabledTextColor
                bottomPadding: Meui.Units.largeSpacing
            }

            RowLayout {
                Layout.fillWidth: true
                Image {
                    id: currentUserImage
                    width: 64
                    height: width
                    sourceSize: Qt.size(width, height)
                    source: "file:///" + currentUser.iconFileName

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Item {
                            width: currentUserImage.width
                            height: width

                            Rectangle {
                                anchors.fill: parent
                                radius: width / 2
                            }
                        }
                    }
                }
                Label {
                    Layout.alignment: Qt.AlignVCenter
                    id: currentUserLabel
                    text: currentUser.displayName
                    font.pointSize: 16
                    bottomPadding: Meui.Units.smallSpacing
                    leftPadding: Meui.Units.largeSpacing
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    id: currentUserLabel2
                    text: `(${currentUser.userName})`
                    color: Meui.Theme.disabledTextColor
                    visible: currentUser.displayName !== currentUser.userName
                    font.pointSize: 16
                    bottomPadding: Meui.Units.smallSpacing
                }

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    text: additionalSettings.shown ? qsTr("Hide additional settings") : qsTr("Show additional settings")
                    onClicked: additionalSettings.toggle()
                }
            }

            Hideable {
                id: additionalSettings
                HorizontalDivider {}

                Label {
                    text: qsTr("Additional settings")
                    color: Meui.Theme.disabledTextColor
                    Layout.bottomMargin: Meui.Units.largeSpacing
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.bottomMargin: Meui.Units.smallSpacing

                    Label {
                        text: qsTr("Automatic login")
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Switch {
                        id: automaticLoginSwitch
                        Layout.fillHeight: true
                        leftPadding: 0
                        rightPadding: 0
                        onCheckedChanged: currentUser.automaticLogin = checked
                    }

                    Component.onCompleted: {
                        automaticLoginSwitch.checked = currentUser.automaticLogin
                    }
                }
            }
        }
    }
}
