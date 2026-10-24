import Quickshell.Services.UPower
import QtQuick
import qs.base
import qs.config

MouseRec {
    id: root

    anchors {
        top: parent.top
        bottom: parent.bottom
        topMargin: 2.0
        bottomMargin: 2.0
    }
    width: statusText.width + 10 * 2
    color: root.hovered ? Qt.darker(Config.batteryBgColor, 1.1) : Config.batteryBgColor

    topRightRadius: height / 2
    bottomRightRadius: height / 2

    StyledText {
        id: statusText
        anchors.centerIn: parent
        rightPadding: 8

        color: Config.batteryTextColor
        text: BatterySingleton.batteryStateText(UPower.displayDevice.state, UPower.displayDevice.percentage)
    }

    onEntered: () => {
        tooltip.prepareToShow(root, BatterySingleton.tooltipText())
    }

    onExited: () => {
        tooltip.hide()
    }

    ToolTip {
        id: tooltip
    }
}
