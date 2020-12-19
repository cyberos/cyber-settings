import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui

Page {
    id: page

    property alias headerVisible: headerItem.visible
    property string headerTitle

    property bool canGoBack: false

    signal backClicked()

    background: Rectangle {
        color: "transparent"
    }

    header: Item {
        id: headerItem
        width: headerLayout.implicitWidth
        height: headerLayout.implicitHeight + Meui.Units.largeSpacing * 2

        RowLayout {
            id: headerLayout
            anchors.margins: Meui.Units.largeSpacing * 2
            anchors.fill: parent
            spacing: Meui.Units.largeSpacing

            IconButton {
                width: headerLabel.height * 0.8
                height: width
                id: goBack
                source: "qrc:/images/go-previous.svg"
                visible: page.canGoBack
                onClicked: page.backClicked()

            }

            Label {
                id: headerLabel
                text: page.headerTitle
                font.pointSize: 18
                font.bold: true
                Layout.fillWidth: true
            }
        }
    }
}
