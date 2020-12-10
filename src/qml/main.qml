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

    minimumWidth: 900
    minimumHeight: 600

    background: Rectangle {
        color: Meui.Theme.viewBackgroundColor

        Behavior on color {
            ColorAnimation {
                duration: 250
            }
        }
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
        id: batteryPage
        BatteryPage {}
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
            initialItem: displayPage
            clip: true

            pushEnter: Transition {}
            pushExit: Transition {}

            Rectangle {
                anchors.fill: parent
                color: Meui.Theme.backgroundColor

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
            stackView.push(displayPage)
            break;
        case 1:
            stackView.push(appearancePage)
            break;
        case 2:
            stackView.push(batteryPage)
            break;
        case 3:
            stackView.push(aboutPage)
            break;
        }
    }
}
