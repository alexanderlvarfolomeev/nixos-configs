import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.base
import qs.config

Rectangle {
    id: root
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    implicitWidth: Config.languageFontSize * 2.5
    bottomRightRadius: Math.round(implicitWidth / 4)
    bottomLeftRadius: Math.round(implicitWidth / 4)
    gradient: Config.languageBgGradient

    StyledText {
        id: powerIcon
        anchors.centerIn: parent
        text: String.fromCodePoint(...KeyboardLayout.currentLayoutCode.toUpperCase().split('').map(c => 127397 + c.charCodeAt()))
        font.pixelSize: Config.languageFontSize
    }
}