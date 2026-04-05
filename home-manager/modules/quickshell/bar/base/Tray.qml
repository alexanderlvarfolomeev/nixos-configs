import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

Rectangle {
  id: root

  anchors {
    top: parent.top
    bottom: parent.bottom
  }
  width: trayRow.width + 10 * 2
  color: "transparent"

  Row {
    id: trayRow

    spacing: 10

    anchors {
      top: parent.top
      bottom: parent.bottom
    }

    Repeater {
      id: trayRepeater

      anchors {
        top: parent.top
        bottom: parent.bottom
      }

      model: SystemTray.items.values

      IconImage {
        required property var modelData

        anchors.verticalCenter: parent.verticalCenter

        implicitSize: 24

        source: modelData.icon
      }
    }
  }
}