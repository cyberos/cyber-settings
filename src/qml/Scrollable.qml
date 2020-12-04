import QtQuick 2.4
import QtQuick.Controls 2.4

Flickable {
    id: root
    flickableDirection: Flickable.VerticalFlick
    clip: true

    topMargin: rootWindow.edgeMargins / 2
    leftMargin: rootWindow.edgeMargins
    rightMargin: rootWindow.edgeMargins

    // contentHeight: contentItem.childrenRect.height
    // contentWidth: parent.width

    contentWidth: width - (leftMargin + rightMargin)

    ScrollBar.vertical: ScrollBar {}
}
