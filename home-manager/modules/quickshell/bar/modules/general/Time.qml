import QtQuick
import qs.base
import qs.config

Rectangle {
    id: root
    anchors {
        topMargin: Config.timeVerticalMargin
        bottomMargin: Config.timeVerticalMargin
        top: parent.top
        bottom: parent.bottom
    }
    implicitWidth: Config.timeFontSize * 5.4

    color: "transparent"
    radius: Config.barHeight / 2 - Config.timeVerticalMargin

    Rectangle {
        id: transparentGradient
        opacity: 0.8
        radius: parent.radius
        anchors.fill: parent
        gradient: Config.timeBgGradient
    }

    ShadowedStyledText {
        id: timeText
        anchors.centerIn: parent
        text: TimeTimer.time
        font.pixelSize: Config.timeFontSize
        color: Config.timeTextColor
    }
}
