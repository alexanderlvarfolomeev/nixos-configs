import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.base as Base

Item {
  id: root
  required property var anchorWindow

  Component {
    id: popupComponent

    PopupWindow {
      id: popupWindow
      implicitHeight: 332
      implicitWidth: 820
      visible: true
      color: "transparent"

      readonly property real borderWidth: 2
      readonly property real borderRadius: 10

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
        color: "#4020242b"

        anchors.centerIn: parent
        implicitHeight: popupWindow.implicitHeight - popupWindow.borderWidth * 2
        implicitWidth: popupWindow.implicitWidth - popupWindow.borderWidth * 2

        bottomLeftRadius: popupWindow.borderRadius
        bottomRightRadius: popupWindow.borderRadius

        Column {
          id: dashColumn
          anchors.fill: parent
          spacing: 0

          // Rectangle {
          //   id: tabRowRect
          //   color: "transparent"

          //   anchors {
          //     left: dashColumn.left
          //     right: dashColumn.right
          //   }

          //   height: 68

          //   Row {
          //     id: tabRow

          //     anchors.fill: parent

          //     Repeater {
          //       id: tabRepeater

          //       model: ["Dash", "Resources", "Player"]

          //       Base.MouseRec {
          //         required property string modelData

          //         height: tabRow.height
          //         width: tabRow.width / tabRepeater.model.length

          //         color: "blue"

          //         Text {
          //           anchors.centerIn: parent
          //           color: "white"
          //           font.pixelSize: 20
          //           font.bold: true
          //           font.family: "JetBrains Mono NF"

          //           text: parent.modelData
          //         }
          //       }
          //     }
          //   }
          // }

          // Rectangle {
          //   id: columnLine
          //   color: "#800071c5"

          //   anchors {
          //     horizontalCenter: dashColumn.horizontalCenter
          //   }
          //   height: 2
          //   width: dashColumn.width * 0.9
          //   topLeftRadius: 1
          //   topRightRadius: 1
          //   bottomLeftRadius: 1
          //   bottomRightRadius: 1
          // }

          Rectangle {
            id: tabRect
            color: "#c0003b5b"

            anchors.horizontalCenter: parent.horizontalCenter
            height: dashColumn.height // - tabRowRect.height // - columnLine.height
            width: dashColumn.width

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
          color: "#00b4d8"
          width: popupWindow.borderWidth
        }

        bottomLeftRadius: popupWindow.borderRadius
        bottomRightRadius: popupWindow.borderRadius
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
      console.log("Toggled!")
      dashLoader.active = !dashLoader.active
      ResourceSingleton.active = dashLoader.active // todo: make it dependency
    }
  }
}
