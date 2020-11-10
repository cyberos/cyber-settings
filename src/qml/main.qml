import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui

ApplicationWindow {
    visible: true
    width: 900
    height: 600
    title: qsTr("Settings")
    id: rootWindow

    background: Rectangle {
        color: Meui.Theme.backgroundColor

        Behavior on color {
            ColorAnimation {
                duration: 250
            }
        }
    }

    Component {
        id: generalPage
        GeneralPage {}
    }

    Component {
        id: displayPage
        DisplayPage {}
    }

    Component {
        id: appearancePage
        AppearancePage {}
    }

    Component {
        id: aboutPage
        AboutPage {}
    }

    RowLayout {
        anchors.fill: parent

        SideBar {
            Layout.fillHeight: true

            onCurrentIndexChanged: {
                switchPage(currentIndex)
            }
        }

        StackView {
            id: stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: generalPage
            clip: true

            Rectangle {
                anchors.fill: parent
                color: Meui.Theme.darkMode ? Qt.darker(Meui.Theme.backgroundColor, 1.5) :
                                             Qt.darker(Meui.Theme.backgroundColor, 1.05)

                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }
            }
        }
    }

    function switchPage(index) {
        switch (index) {
        case 0:
            stackView.push(generalPage)
            break;
        case 1:
            stackView.push(displayPage)
            break;
        case 2:
            stackView.push(appearancePage)
            break;
        case 3:
            stackView.push(aboutPage)
            break;
        }
    }
}
