import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui

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
        topPadding: Meui.Units.largeSpacing + 10
        leftPadding: Meui.Units.largeSpacing * 2
        rightPadding: Meui.Units.largeSpacing * 2
    }
}
