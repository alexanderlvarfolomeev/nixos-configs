import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.modules.hyprland

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

      model: ScriptModel {
        values: AppSingleton.filteredTopLevels
        objectProp: "key"
      }

      IconImage {
        required property var modelData

        anchors.verticalCenter: parent.verticalCenter
        implicitSize: 24
        source: Quickshell.iconPath(AppSingleton.guessIcon(modelData.id))
      }
    }
  }
}
