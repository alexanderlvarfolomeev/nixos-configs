import QtQuick
import Quickshell
import qs.base

MouseRec {
  id: root

  property string icon
  property bool canUse

  enabled: canUse
  color: hovered ? "#20000000" : "transparent"

  implicitWidth: iconText.implicitHeight + 4
  implicitHeight: implicitWidth

  topLeftRadius: 5
  topRightRadius: 5
  bottomLeftRadius: 5
  bottomRightRadius: 5

  Text {
    id: iconText
    
    anchors.centerIn: parent

    text: root.icon
    color: root.canUse ? "black" : "grey"
    
    font.pixelSize: 32
    font.bold: true
    font.family: "Material Symbols Rounded"
  }
}
