import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
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

            Image {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                width: 128
                height: width
                sourceSize: Qt.size(width, height)
                source: "file:///" + currentUser.iconFileName
            }

            Label {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                text: currentUser.userName
                font.pointSize: 24
                font.bold: true
                bottomPadding: Meui.Units.largeSpacing * 2
                leftPadding: Meui.Units.largeSpacing * 2
                rightPadding: Meui.Units.largeSpacing * 2
            }
        }
    }
}
