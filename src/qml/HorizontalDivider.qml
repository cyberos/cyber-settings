import QtQuick 2.4
import QtQuick.Layouts 1.3
import MeuiKit 1.0 as Meui

Rectangle {
    height: 1
    Layout.fillWidth: true
    color: Meui.Theme.disabledTextColor
    opacity: Meui.Theme.darkMode ? 0.3 : 0.2
}
