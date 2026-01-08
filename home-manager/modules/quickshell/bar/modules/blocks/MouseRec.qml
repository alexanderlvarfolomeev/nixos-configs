import QtQuick

Rectangle {
  id: root

  MouseArea {
    id: recArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: root.onClicked()
  }

  property bool hovered: recArea.containsMouse

  property var onClicked: (mouse) => {}
}