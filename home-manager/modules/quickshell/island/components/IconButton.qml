import QtQuick
import QtQuick.Controls
import qs.config

Rectangle {
    id: root

    property string icon: ""
    property string tooltip: ""
    property bool checked: false
    property int buttonSize: 32
    signal clicked

    implicitWidth: buttonSize
    implicitHeight: buttonSize
    radius: buttonSize / 2
    color: checked ? Theme.accent : (pointer.hovered ? Theme.raisedHover : Theme.raised)
    border.color: checked ? "transparent" : Theme.border
    border.width: 1

    Behavior on color { ColorAnimation { duration: 120 } }

    IconLabel {
        anchors.centerIn: parent
        text: root.icon
        iconSize: Math.round(root.buttonSize * 0.56)
        color: root.checked ? Theme.activeText : Theme.text
    }

    ToolTip.visible: pointer.hovered && tooltip.length > 0
    ToolTip.text: tooltip
    ToolTip.delay: 600

    HoverHandler { id: pointer }
    TapHandler { onTapped: root.clicked() }
}
