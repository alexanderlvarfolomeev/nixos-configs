import QtQuick
import qs.base as Base
import qs.modules.island.config

Rectangle {
    id: root

    property string icon: "toggle_on"
    property string title: "Toggle"
    property string subtitle: ""
    property bool active: false
    signal clicked

    radius: 15
    color: active ? Theme.accentSoft : (pointer.hovered ? Theme.raisedHover : Theme.raised)
    border.color: active ? Theme.accent : Theme.border
    border.width: 1

    Behavior on color { ColorAnimation { duration: 150 } }
    Behavior on border.color { ColorAnimation { duration: 150 } }

    Row {
        anchors {
            fill: parent
            margins: 12
        }
        spacing: 10

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 34
            height: 34
            radius: 17
            color: root.active ? Theme.accent : "#18ffffff"

            IconLabel {
                anchors.centerIn: parent
                text: root.icon
                iconSize: 19
                color: root.active ? Theme.activeText : Theme.text
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 44
            spacing: 1

            Base.TextShadow {
                width: parent.width
                text: root.title
                color: Theme.text
                elide: Text.ElideRight
                font { family: Theme.fontFamily; pixelSize: 13; weight: Font.DemiBold }
            }

            Base.TextShadow {
                width: parent.width
                text: root.subtitle
                color: root.active ? Theme.text : Theme.textMuted
                elide: Text.ElideRight
                font { family: Theme.fontFamily; pixelSize: 10 }
            }
        }
    }

    HoverHandler { id: pointer }
    TapHandler { onTapped: root.clicked() }
}
