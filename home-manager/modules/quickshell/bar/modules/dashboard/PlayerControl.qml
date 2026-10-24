import QtQuick
import qs.base
import qs.config

MouseRec {
  id: root

  property string icon
  property bool canUse

  enabled: canUse
  color: hovered ? Config.hoveredTransparency : "transparent"

  implicitWidth: iconText.implicitHeight + 4
  implicitHeight: implicitWidth

  radius: Config.playerControlRadius

  MaterialText {
    id: iconText
    
    anchors.centerIn: parent

    text: root.icon
    color: root.canUse ? Config.playerControlActiveColor : Config.playerControlInactiveColor
  }
}
