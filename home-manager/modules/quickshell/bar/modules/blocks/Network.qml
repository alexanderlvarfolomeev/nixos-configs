import Quickshell
import Quickshell.Widgets
import QtQuick

Rectangle {
  id: root

  anchors {
    top: parent.top
    bottom: parent.bottom
  }
  width: statusText.width + 10 * 2
  color: "#00b4d8"

  Text {
    id: statusText
    anchors.centerIn: parent

    font.pixelSize: 20
    font.bold: true
    font.family: "JetBrains Mono NF"

    color: "#e6e6fa"
    text: NetworkSingleton.networkStateText(NetworkSingleton.state, NetworkSingleton.network, NetworkSingleton.rssi)
  }
}