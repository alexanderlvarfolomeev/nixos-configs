import QtQuick
import qs.base
import qs.config

Rectangle {
    id: root

    readonly property string layoutCode: KeyboardLayout.currentLayoutCode.toUpperCase()
    readonly property string layoutLabel: /^[A-Z]{2}$/.test(layoutCode)
        ? String.fromCodePoint(...layoutCode.split('').map(c => 127397 + c.charCodeAt()))
        : layoutCode
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
        text: root.layoutLabel
        font.pixelSize: Config.languageFontSize
    }
}
