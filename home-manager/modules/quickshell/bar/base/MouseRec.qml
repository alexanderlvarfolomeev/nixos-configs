import QtQuick

Rectangle {
  id: root

  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true

    onClicked: mouse => root.onClicked(mouse)
    onPressAndHold: mouse => root.onPressAndHold(mouse)
    onEntered: () => root.onEntered()
    onExited: () => root.onExited()
  }

  // HoverHandler

  property bool extraHoveredCondition: true
  readonly property bool hovered: extraHoveredCondition && mouse.containsMouse

  property var onClicked: (mouse) => {}
  property var onPressAndHold: mouse => onClicked(mouse)
  property var onEntered: () => {}
  property var onExited: () => {}
}