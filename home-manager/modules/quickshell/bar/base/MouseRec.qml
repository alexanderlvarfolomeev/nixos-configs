import QtQuick

Rectangle {
  id: root

  signal clicked(var mouse)
  signal pressAndHold(var mouse)
  signal entered()
  signal exited()

  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true

    onClicked: mouse => root.clicked(mouse)
    onPressAndHold: mouse => root.pressAndHold(mouse)
    onEntered: root.entered()
    onExited: root.exited()
  }

  property bool extraHoveredCondition: true
  readonly property bool hovered: extraHoveredCondition && mouse.containsMouse

}
