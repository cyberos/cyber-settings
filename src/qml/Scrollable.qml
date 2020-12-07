import QtQuick 2.4
import QtQuick.Controls 2.4
import MeuiKit 1.0 as Meui

Flickable {
    id: root
    flickableDirection: Flickable.VerticalFlick
    clip: true

    topMargin: Meui.Units.largeSpacing
    leftMargin: Meui.Units.largeSpacing
    rightMargin: Meui.Units.largeSpacing

    contentWidth: width - (leftMargin + rightMargin)

    ScrollBar.vertical: ScrollBar {}
}
