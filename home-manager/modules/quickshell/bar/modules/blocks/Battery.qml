import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    width: statusText.width + 10 * 2
    color: "white"

    Text {
        id: statusText
        anchors.centerIn: parent
        text: UPower.displayDevice
    }
}