import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Item {
  id: root
  property string text: ""

  property bool visibleCondition: false

  property Item contentItem: Rectangle {
      id: contentItem
      anchors.centerIn: parent
      opacity: false
      Component.onCompleted: opacity = true
      width: tooltipText.width + 10 * 2

      Text {
        id: tooltipText
        text: root.text
      }
  }

  Loader {
    id: tooltipLoader
    anchors.fill: parent
    active: root.visibleCondition
    sourceComponent: PopupWindow {
      visible: true
      anchor {
        item: root.parent
        edges: Edges.Bottom
        gravity: Edges.Bottom
      }

      color: "#C0A0A0A0"
      implicitWidth: root.contentItem.implicitWidth + 10 * 2
      implicitHeight: root.contentItem.implicitHeight + 5 * 2

      data: [root.contentItem]
    }
  }
}