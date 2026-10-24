import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Item {
  id: root
  required property var anchorWindow

  PopupWindow {
    id: popupWindow

    readonly property bool expanded: pinned || islandHover.hovered || collapseTimer.running
    property bool pinned: false

    visible: root.anchorWindow !== null
    color: "transparent"
    implicitWidth: expanded
      ? Config.dashboardSinglePartWidth * 3
      : Config.dashboardIslandWidth
    implicitHeight: expanded
      ? Config.dashboardHeight
      : Config.dashboardIslandHeight

    anchor {
      window: root.anchorWindow
      edges: Edges.Bottom
      gravity: Edges.Bottom

      rect {
        x: root.anchorWindow ? root.anchorWindow.width / 2 : 0
        y: root.anchorWindow
          ? root.anchorWindow.height - Config.dashboardIslandOverlap
          : 0
      }
    }

    Behavior on implicitWidth {
      NumberAnimation {
        duration: Config.dashboardAnimationDuration
        easing.type: Easing.OutCubic
      }
    }

    Behavior on implicitHeight {
      NumberAnimation {
        duration: Config.dashboardAnimationDuration
        easing.type: Easing.OutCubic
      }
    }

    onExpandedChanged: {
      ResourceSingleton.active = expanded

      if (expanded) {
        contentUnloadTimer.stop()
      } else {
        contentUnloadTimer.restart()
      }
    }

    Rectangle {
      id: island
      anchors.fill: parent
      clip: true
      radius: popupWindow.expanded
        ? Config.dashboardBorderRadius
        : height / 2
      border {
        color: Config.dashboardBorderColor
        width: Config.dashboardBorderWidth
      }

      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: Config.barColor
        }
        GradientStop {
          position: popupWindow.expanded ? 0.18 : 0.55
          color: Config.dashboardBgColor
        }
        GradientStop {
          position: 1.0
          color: popupWindow.expanded ? Config.dashboardBgColor : "#d0003b5b"
        }
      }

      Behavior on radius {
        NumberAnimation {
          duration: Config.dashboardAnimationDuration
          easing.type: Easing.OutCubic
        }
      }

      HoverHandler {
        id: islandHover

        onHoveredChanged: {
          if (hovered) {
            collapseTimer.stop()
          } else if (!popupWindow.pinned) {
            collapseTimer.restart()
          }
        }
      }

      Loader {
        id: dashboardContent
        anchors {
          fill: parent
          margins: Config.dashboardBorderWidth
        }
        active: popupWindow.expanded || contentUnloadTimer.running
        opacity: popupWindow.expanded ? 1 : 0
        sourceComponent: dashboardComponent

        Behavior on opacity {
          NumberAnimation {
            duration: 180
            easing.type: Easing.OutQuad
          }
        }
      }

      Row {
        id: islandLabel
        anchors.centerIn: parent
        spacing: 9
        opacity: popupWindow.expanded ? 0 : 1
        visible: opacity > 0

        Behavior on opacity {
          NumberAnimation {
            duration: 120
            easing.type: Easing.OutQuad
          }
        }

        Rectangle {
          anchors.verticalCenter: parent.verticalCenter
          width: 8
          height: 8
          radius: 4
          color: Config.dashboardBorderColor

          SequentialAnimation on opacity {
            loops: Animation.Infinite
            NumberAnimation {
              from: 1
              to: 0.5
              duration: 1200
              easing.type: Easing.InOutSine
            }
            NumberAnimation {
              from: 0.5
              to: 1
              duration: 1200
              easing.type: Easing.InOutSine
            }
          }
        }

        Text {
          anchors.verticalCenter: parent.verticalCenter
          text: "DASHBOARD"
          color: "#e6e6fa"
          font {
            family: Config.fontFamily
            pixelSize: 12
            bold: true
            letterSpacing: 1.4
          }
        }

        Text {
          anchors.verticalCenter: parent.verticalCenter
          text: "⌄"
          color: Config.dashboardBorderColor
          font.pixelSize: 16
        }
      }

      Rectangle {
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
          leftMargin: Config.dashboardBorderRadius
          rightMargin: Config.dashboardBorderRadius
        }
        height: 1
        color: "#60ffffff"
        opacity: popupWindow.expanded ? 0.45 : 0.7
      }
    }

    Timer {
      id: collapseTimer
      interval: 260
      repeat: false
    }

    Timer {
      id: contentUnloadTimer
      interval: Config.dashboardAnimationDuration + 80
      repeat: false
    }

    Component.onDestruction: ResourceSingleton.active = false
  }

  Component {
    id: dashboardComponent

    Row {
      spacing: 0

      Resources {
        implicitHeight: parent.height
        implicitWidth: parent.width / 3
        anchors.verticalCenter: parent.verticalCenter
      }

      User {
        implicitHeight: parent.height
        implicitWidth: parent.width / 3
        anchors.verticalCenter: parent.verticalCenter
      }

      Player {
        implicitHeight: parent.height
        implicitWidth: parent.width / 3
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  IpcHandler {
    target: "dashboard"

    function toggle() {
      popupWindow.pinned = !popupWindow.pinned
    }
  }
}
