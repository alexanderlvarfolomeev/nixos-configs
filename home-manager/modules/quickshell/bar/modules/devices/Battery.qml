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
    }
    width: statusText.width + 10 * 2
    color: "#003b5b"

    topRightRadius: height / 2
    bottomRightRadius: height / 2

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

    // ToolTip {
    //     id: tooltip
    //     visible: root.hovered
    //     text: "todo"
    //     delay: 500

    //     background: Rectangle {
    //         color: "#d8241b20"
    //         opacity: 0.9
    //     }

    //     contentItem: Text {
    //         text: tooltip.text // Binds to the ToolTip.text property
    //         font: tooltip.font
    //         color: "#00b4d8" // Change the text color
    //         wrapMode: Text.Wrap
    //     }

    //     // popupType: Popup.Window
    //     // topMargin: 50
    // }
}