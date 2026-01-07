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
  width: windowRow.width + 10 * 2
  color: "white"

  Row {
    id: windowRow

    spacing: 10

    anchors {
      top: parent.top
      bottom: parent.bottom
    }

    Repeater {
      id: windowRepeater

      anchors {
        top: parent.top
        bottom: parent.bottom
      }

      model: DesktopEntries.applications.values

      // IconImage {
      //   required property var modelData

      //   anchors.verticalCenter: parent.verticalCenter

      //   implicitSize: 24

      //   source: Quickshell.iconPath(modelData.icon)
      // }

      Text {
        required property var modelData

        anchors.verticalCenter: parent.verticalCenter

        text: JSON.stringify(modelData.command)
      }
    }
  }
}