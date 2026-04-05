import QtQuick

StyledText {
  id: root

  StyledText {
    id: shadow
    anchors.centerIn: parent
    anchors.horizontalCenterOffset: 2
    anchors.verticalCenterOffset: 2
    text: root.text
    font.pixelSize: root.font.pixelSize
    color: "black"
    z: -1
  }
}