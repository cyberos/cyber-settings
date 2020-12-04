import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {
    id: page

    property string headerTitle

    background: Rectangle {
        color: "transparent"
    }

    header: Label {
        id: headerLabel
        text: page.headerTitle
        font.pointSize: 18
        font.bold: true
        topPadding: topMargin
        leftPadding: rootWindow.edgeMargins
        rightPadding: rootWindow.edgeMargins
    }

//    default property alias contents: contents.data

//    Flickable {
//        id: flickable
//        clip: true
//        anchors.fill: parent
//        ScrollBar.vertical: ScrollBar {}
//        flickableDirection: Flickable.VerticalFlick

//        contentWidth: page.width
//        contentHeight: contents.height

//        Item {
//            id: contents
//            width: flickable.width
//            height: childrenRect.height
//        }
//    }
}
