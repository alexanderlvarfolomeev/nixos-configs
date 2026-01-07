import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

Rectangle {
  id: root

  anchors {
    top: parent.top
    bottom: parent.bottom
  }
  width: wlrRow.width + 10 * 2
  color: "transparent"

  Row {
    id: wlrRow

    spacing: 15

    anchors {
      top: parent.top
      bottom: parent.bottom
    }

    Repeater {
      id: wlrRepeater

      anchors {
        top: parent.top
        bottom: parent.bottom
      }

      model: AppSingleton.filteredTopLevels

      Rectangle {
        id: wlrRepeaterDelegate

        required property var modelData

        anchors.verticalCenter: parent.verticalCenter

        color: "transparent"

        height: wlrIcon.actualSize
        width: wlrIcon.actualSize

        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          ToolTip {
            visible: parent.containsMouse // Binds the tooltip visibility to the hovered state
            text: wlrRepeaterDelegate.modelData.id + " (" + wlrRepeaterDelegate.modelData.title + ")"
            delay: 500 // Optional: delay showing the tooltip by 500ms
            // topMargin: 20
            // clip: false
          }
        }

        IconImage {
          id: wlrIcon

          anchors.centerIn: parent

          implicitSize: 24

          source: Quickshell.iconPath(AppSingleton.guessIcon(wlrRepeaterDelegate.modelData.id))
        }

      }
    }
  }
}