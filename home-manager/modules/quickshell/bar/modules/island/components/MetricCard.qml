import QtQuick
import qs.base as Base
import qs.modules.island.config

Rectangle {
    id: root
    property string icon: "memory"
    property string title: ""
    property string value: ""
    property string detail: ""
    property real ratio: 0
    radius: 16
    color: Theme.raised
    border.color: Theme.border

    IconLabel {
        id: glyph
        anchors { left: parent.left; leftMargin: 14; top: parent.top; topMargin: 14 }
        text: root.icon
        iconSize: 24
        color: Theme.accent
    }
    Base.TextShadow {
        anchors { left: glyph.right; leftMargin: 10; top: glyph.top }
        text: root.title
        color: Theme.text
        font { family: Theme.fontFamily; pixelSize: 13; weight: Font.DemiBold }
    }
    Base.TextShadow {
        anchors { right: parent.right; rightMargin: 14; top: glyph.top }
        text: root.value
        color: Theme.text
        font { family: Theme.monoFamily; pixelSize: 13; weight: Font.DemiBold }
    }
    Base.TextShadow {
        anchors { left: parent.left; right: parent.right; top: glyph.bottom; margins: 14; topMargin: 7 }
        text: root.detail
        color: Theme.textMuted
        elide: Text.ElideRight
        font { family: Theme.fontFamily; pixelSize: 10 }
    }
    Rectangle {
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom; margins: 14 }
        height: 5
        radius: 3
        color: Theme.accentSoft
        Rectangle {
            width: parent.width * Math.max(0, Math.min(1, root.ratio))
            height: parent.height
            radius: parent.radius
            color: Theme.accent
            Behavior on width { NumberAnimation { duration: 240 } }
        }
    }
}
