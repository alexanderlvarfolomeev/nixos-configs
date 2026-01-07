import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    width: statusText.width + 10 * 2
    color: "#003b5b"

    Text {
        id: statusText
        anchors.centerIn: parent

        font.pixelSize: 20
        font.bold: true
        font.family: "JetBrains Mono NF"

        color: "#ff7900"
        text: BatterySingleton.batteryStateText(UPower.displayDevice.state, UPower.displayDevice.percentage)
    }
}