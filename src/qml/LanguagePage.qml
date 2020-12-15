import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui
import org.cyber.Settings 1.0 as Settings

ItemPage {
    headerTitle: qsTr("Language")

    Settings.Language {
        id: language
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: listView

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: language.languages
            clip: true

            topMargin: Meui.Units.largeSpacing
            leftMargin: Meui.Units.largeSpacing * 2
            rightMargin: Meui.Units.largeSpacing * 2
            spacing: Meui.Units.largeSpacing

            currentIndex: language.currentLanguage

            ScrollBar.vertical: ScrollBar {}

            delegate: MouseArea {
                property bool isSelected: index == listView.currentIndex

                id: item
                width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
                height: 50
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton

                onClicked: {
                    listView.currentIndex = index
                }

                Rectangle {
                    anchors.fill: parent
                    color: isSelected ? Meui.Theme.highlightColor : item.containsMouse ? Meui.Theme.disabledTextColor : "transparent"
                    opacity: 0.1
                    radius: Meui.Theme.smallRadius
                }

                Label {
                    anchors.fill: parent
                    text: modelData
                }
            }

            onCurrentIndexChanged: {
                language.setCurrentLanguage(currentIndex)
            }
        }

        Item {
            height: Meui.Units.largeSpacing
        }

        RowLayout {
            spacing: 0

            Item {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Change")
            }

            Item {
                width: Meui.Units.largeSpacing * 2
            }
        }

        Item {
            height: Meui.Units.largeSpacing
        }
    }


}
