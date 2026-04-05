import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import qs.base as Base
import qs.config

Base.MouseRec {
  id: root

  anchors {
    top: parent.top
    bottom: parent.bottom
    topMargin: 2.0
    bottomMargin: 2.0
  }

  topLeftRadius: height / 2
  bottomLeftRadius: height / 2

  width: statusText.width + 10 * 2
  color: root.hovered ? Qt.darker("#00b4d8", 1.1) : "#00b4d8"

  Text {
    id: statusText
    anchors.centerIn: parent
    leftPadding: 8

    font.pixelSize: 20
    font.bold: true
    font.family: Config.fontFamily

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