import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ItemPage {
    headerTitle: qsTr("Battery")

    Label {
        anchors.centerIn: parent
        text: qsTr("No battery found")
    }
}
