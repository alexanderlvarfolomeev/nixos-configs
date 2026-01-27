import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import "../blocks" as Blocks

Blocks.MouseRec {
  id: root

  anchors {
    top: parent.top
    bottom: parent.bottom
  }

  topLeftRadius: height / 2
  bottomLeftRadius: height / 2

  width: statusText.width + 10 * 2
  color: "#00b4d8"

  Text {
    id: statusText
    anchors.centerIn: parent
    leftPadding: 8

    font.pixelSize: 20
    font.bold: true
    font.family: "JetBrains Mono NF"

    color: "#e6e6fa"
    text: NetworkSingleton.networkStateText(NetworkSingleton.state, NetworkSingleton.network, NetworkSingleton.rssi)
  }

  onClicked: function() {
    iwgtk.startDetached()
  }

  Process {
    id: iwgtk
    running: false
    command: ["bash",  "/home/aorise/.local/scripts/toggle.sh", "iwgtk"]
  }
}