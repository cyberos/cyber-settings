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
                    text: currentUser.userName
                    font.pointSize: 16
                    // font.bold: true
                    bottomPadding: Meui.Units.smallSpacing
                    leftPadding: Meui.Units.largeSpacing
                }
            }

            /*
             * This will be useful when creating additional settings
             * for additional users. Currently though, I don't know
             * how to use the AccountsManager to get other users.
             * For now, I'm leaving this here as a proof-of-concept.
             *  - @omaemae
             */

            Button {
                text: "FIXME: Placeholder"
                onClicked: hideable.toggle()
            }
            
            Hideable {
                id: hideable
                Label {
                    text: "You found a placeholder!"
                }
            }
        }
    }
}
