import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../blocks" as Blocks

Blocks.MouseRec {
    id: root

    anchors {
        top: parent.top
        bottom: parent.bottom
        topMargin: 2.0
        bottomMargin: 2.0
    }
    width: statusText.width + 10 * 2
    color: root.hovered ? Qt.darker("#00449a", 1.1) : "#00449a"

    topRightRadius: height / 2
    bottomRightRadius: height / 2

    property Component tooltipComponent: Component {
        Blocks.ToolTip {}
    }
    property var tooltip: null

    Text {
        id: statusText
        anchors.centerIn: parent
        rightPadding: 8

        font.pixelSize: 20
        font.bold: true
        font.family: "JetBrains Mono NF"

        color: "#ff7900"
        text: BatterySingleton.batteryStateText(UPower.displayDevice.state, UPower.displayDevice.percentage)
    }

    // onClicked: () => {
    //     if (tooltip) {
    //         tooltip.hide()
    //         tooltip.destroy()
    //     } else {
    //         tooltip = tooltipComponent.createObject(null)
    //         console.log(tooltip)
    //         tooltip.prepareToShow(root, BatterySingleton.tooltipText())
    //     }
    // }

    onEntered: () => {
        if (tooltip) {
            tooltip.refreshText(BatterySingleton.tooltipText())
        } else {
            tooltip = tooltipComponent.createObject(null)
            tooltip.prepareToShow(root, BatterySingleton.tooltipText())
        }
    }

    onExited: () => {
        if (tooltip) {
            tooltip.hide()
            tooltip.destroy()
        }
    }
}