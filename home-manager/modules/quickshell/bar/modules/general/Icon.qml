import QtQuick
import Quickshell
import qs.base
import qs.config
import qs.services

MouseRec {
    id: root
    implicitWidth: Config.barHeight
    implicitHeight: Config.barHeight
    color: "transparent"

    onClicked: function() {
        Quickshell.execDetached(["rofi", "-show", "drun"])
    }
    Image {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        source: Quickshell.iconPath(OsInfo.osLogo)
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Rectangle {
        anchors.fill: parent
        color: root.hovered ? Config.hoveredTransparency : "transparent"
    }

}
