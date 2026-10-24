import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Item {
  id: root
  required property var anchorWindow

  Component {
    id: popupComponent

    PopupWindow {
      id: popupWindow
      implicitHeight: Config.dashboardHeight
      implicitWidth: Config.dashboardSinglePartWidth * 3
      visible: true
      color: "transparent"

      property bool isActive: false

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

        property var diffY: popupWindow.isActive ? 0 : -popupWindow.implicitHeight

        Behavior on anchors.verticalCenterOffset {
          NumberAnimation {
            duration: 400
            easing.type: Easing.OutCubic

            onRunningChanged: {
              if (!running) {
                popupWindow.visible = popupWindow.isActive
              } else {
                popupWindow.visible = true
              }
            }
          }
        }

        anchors {
          centerIn: parent
          verticalCenterOffset: popupRect.diffY
        }

        implicitHeight: popupWindow.implicitHeight - Config.dashboardBorderWidth * 2
        implicitWidth: popupWindow.implicitWidth - Config.dashboardBorderWidth * 2
      
        border {
          color: Config.dashboardBorderColor
          width: Config.dashboardBorderWidth
        }

        bottomLeftRadius: Config.dashboardBorderRadius
        bottomRightRadius: Config.dashboardBorderRadius

        Column {
          id: dashColumn
          anchors.fill: parent
          spacing: 0

          Rectangle {
            id: tabRect

            gradient: Gradient {
                GradientStop { position: 0.0; color: Config.barColor }
                GradientStop { position: 0.2; color: Config.dashboardBgColor }
                GradientStop { position: 1.0; color: Config.dashboardBgColor }
            }

            anchors.horizontalCenter: parent.horizontalCenter
            height: dashColumn.height
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
    }
  }

  Timer {
    id: destroyTimer
    interval: 30000
    repeat: false
    onTriggered: {
      dashLoader.active = false
    }
  }

  Loader {
    id: dashLoader
    sourceComponent: popupComponent
    active: false

    onLoaded: {
      item.isActive = true
      ResourceSingleton.active = true
    }

    function toggle() {
      destroyTimer.stop()
      if (item != null) {
        if (item.isActive) {
          item.isActive = false
          ResourceSingleton.active = false
          destroyTimer.restart()
        } else {
          item.isActive = true
          ResourceSingleton.active = true
        }
      } else {
        dashLoader.active = true
      }
    }
  }

  IpcHandler {
    target: "dashboard"

    function toggle() {
      dashLoader.toggle()
    }
  }
}
