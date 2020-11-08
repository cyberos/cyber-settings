import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {
    id: control

    property string headerTitle

    background: Rectangle {
        color: "transparent"
    }

    header: Label {
        id: headerLabel
        text: control.headerTitle
        font.pointSize: 18
        font.bold: true
        leftPadding: 10
        rightPadding: 10
    }
}
