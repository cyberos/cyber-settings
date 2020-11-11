import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import org.cyber.Settings 1.0
import MeuiKit 1.0 as Meui

ItemPage {
    headerTitle: qsTr("Display")

    Brightness {
        id: brightness
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        clip: true

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10

            Label {
                text: qsTr("Brightness")
                color: Meui.Theme.disabledTextColor
                topPadding: Meui.Units.largeSpacing
                bottomPadding: Meui.Units.largeSpacing
            }

            Label {
                id: brightnessLabel
                text: brightnessSlider.value + "%"
            }

            RowLayout {
                spacing: Meui.Units.largeSpacing

                Image {
                    width: brightnessSlider.height
                    height: width
                    sourceSize.width: width
                    sourceSize.height: heihgt
                    source: "qrc:/images/" + (Meui.Theme.darkMode ? "dark" : "light") + "/display-brightness-low-symbolic.svg"
                }

                Slider {
                    id: brightnessSlider
                    Layout.fillWidth: true
                    value: brightness.value
                    from: 0
                    to: 100
                    stepSize: 1
                    onValueChanged: brightness.setValue(value)
                }

                Image {
                    width: brightnessSlider.height
                    height: width
                    sourceSize.width: width
                    sourceSize.height: heihgt
                    source: "qrc:/images/" + (Meui.Theme.darkMode ? "dark" : "light") + "/display-brightness-symbolic.svg"
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
