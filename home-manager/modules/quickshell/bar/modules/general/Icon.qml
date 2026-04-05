import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.base
import qs.config
import qs.modules.common

MouseRec {
    id: root
    implicitWidth: Config.barHeight
    implicitHeight: Config.barHeight
    color: "transparent"

    onClicked: function() {
        rofi.startDetached()
    }
    Image {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        source: Quickshell.iconPath(SystemSingleton.osLogo)
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Rectangle {
        anchors.fill: parent
        color: root.hovered ? Config.hoveredTransparency : "transparent"
    }

    Process {
        id: rofi
        running: false
        command: [ "rofi", "-show", "drun"]
    }
}