import QtQuick

Rectangle {
  id: root

  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true

    onClicked: root.onClicked()
  }

  // HoverHandler

  property bool extraHoveredCondition: true
  property bool hovered: extraHoveredCondition && mouse.containsMouse

  property var onClicked: (mouse) => {}
}