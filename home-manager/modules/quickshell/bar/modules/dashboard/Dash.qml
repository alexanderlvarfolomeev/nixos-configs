import Quickshell
import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
  id: root
  required property var anchorWindow

  Component {
    id: popupComponent
    PopupWindow {
      id: popupWindow
      implicitHeight: 400
      implicitWidth: anchorWindow.width / 4
      visible: true
      color: "#2620242b"

      anchor {
        window: anchorWindow
        edges: Edges.Bottom
        gravity: Edges.Bottom
        rect {
          x: anchorWindow.width / 2
          y: anchorWindow.height
        }
      }

      // The Rectangle can be moved outside the window frame
      Rectangle {
          id: draggableRect
          width: 100
          height: 100
          color: "red"
          x: 150
          y: 100

          // Use a DragHandler for interactive movement (Qt 6.x recommended)
          DragHandler {
              id: dragHandler
              target: draggableRect
          }

          Text {
              text: "Drag Me"
              anchors.centerIn: parent
              color: "white"
          }
      }

      // A button to reset the item's position for demonstration
      Button {
          text: "Close"
          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
              dashLoader.active = false
          }
      }
    }
  }

  Loader {
    id: dashLoader
    sourceComponent: popupComponent
  }
}
