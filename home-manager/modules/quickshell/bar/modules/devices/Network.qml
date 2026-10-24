import Quickshell
import Quickshell.Io
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

  topLeftRadius: height / 2
  bottomLeftRadius: height / 2

  width: statusText.width + 10 * 2
  color: root.hovered ? Qt.darker(Config.networkBgColor, 1.1) : Config.networkBgColor

  StyledText {
    id: statusText
    anchors.centerIn: parent
    leftPadding: 8

    color: Config.networkTextColor
    text: NetworkSingleton.networkStateText(NetworkSingleton.state, NetworkSingleton.network, NetworkSingleton.rssi)
  }

  onClicked: function() {
    iwgtk.startDetached()
  }

  Process {
    id: iwgtk
    running: false
    command: ["bash", Quickshell.env("HOME") + "/.local/scripts/toggle.sh", "iwgtk"]
  }
}
