import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.base as Base
import qs.config

Item {
  id: root
  required property var anchorWindow

  Component {
    id: popupComponent

    PopupWindow {
      id: popupWindow
      implicitHeight: Config.dashboardHeight
      implicitWidth: Config.dashboardSinglePartWidth * 3 + Config.dashboardBorderWidth * 2
      visible: true
      color: "transparent"

      anchor {
        window: anchorWindow
        edges: Edges.Bottom
        gravity: Edges.Bottom

        rect {
          x: anchorWindow.width / 2
          y: anchorWindow.height
        }
      }

      Rectangle {
        id: popupRect
        color: "transparent"

        anchors.centerIn: parent
        implicitHeight: popupWindow.implicitHeight - Config.dashboardBorderWidth * 2
        implicitWidth: popupWindow.implicitWidth - Config.dashboardBorderWidth * 2

        bottomLeftRadius: Config.dashboardBorderRadius
        bottomRightRadius: Config.dashboardBorderRadius

        Column {
          id: dashColumn
          anchors.fill: parent
          spacing: 0

          Rectangle {
            id: tabRect
            color: Config.dashboardBgColor

            anchors.horizontalCenter: parent.horizontalCenter
            height: dashColumn.height // - tabRowRect.height // - columnLine.height
            width: dashColumn.width

            bottomRightRadius: Config.dashboardBorderRadius
            bottomLeftRadius: Config.dashboardBorderRadius

            Row {
              spacing: 0
              anchors.fill: parent

              Resources {
                implicitHeight: tabRect.height
                implicitWidth: tabRect.width / 3
                anchors.verticalCenter: parent.verticalCenter
              }

              User {
                implicitHeight: tabRect.height
                implicitWidth: tabRect.width / 3
                anchors.verticalCenter: parent.verticalCenter
              }

              Player {
                implicitHeight: tabRect.height
                implicitWidth: tabRect.width / 3
                anchors.verticalCenter: parent.verticalCenter
              }
            }
          }
        }
      }

      Rectangle {
        id: bordersRect
        color: "transparent"
        
        anchors.fill: parent
        
        border {
          color: Config.dashboardBorderColor
          width: Config.dashboardBorderWidth
        }

        bottomLeftRadius: Config.dashboardBorderRadius
        bottomRightRadius: Config.dashboardBorderRadius
      }
    }
  }

  Loader {
    id: dashLoader
    sourceComponent: popupComponent
    active: false
  }

  IpcHandler {
    target: "dashboard"

    function toggle() {
      dashLoader.active = !dashLoader.active
      ResourceSingleton.active = dashLoader.active // todo: make it dependency
    }
  }
}
