pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.base as Base
import qs.modules.island.config

Item {
    id: root
    required property var controller
    property string title: ""
    property string subtitle: ""
    default property alias content: body.data

    property Item chrome: Item {
        parent: root
        anchors.fill: parent

        Item {
            id: header
            anchors { top: parent.top; left: parent.left; right: parent.right; margins: 14 }
            height: 38
            Column {
                anchors { left: parent.left; right: lockButton.left; verticalCenter: parent.verticalCenter; rightMargin: 8 }
                Base.TextShadow {
                    width: parent.width
                    text: root.title
                    color: Theme.text
                    elide: Text.ElideRight
                    font { family: Theme.fontFamily; pixelSize: 16; weight: Font.DemiBold }
                }
                Base.TextShadow {
                    visible: root.subtitle.length > 0
                    width: parent.width
                    text: root.subtitle
                    color: Theme.textMuted
                    elide: Text.ElideRight
                    font { family: Theme.fontFamily; pixelSize: 10 }
                }
            }
            IconButton {
                id: lockButton
                anchors { right: closeButton.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
                icon: "lock"
                tooltip: "Lock session"
                onClicked: Quickshell.execDetached(["loginctl", "lock-session"])
            }
            IconButton {
                id: closeButton
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                icon: "close"
                tooltip: "Close island"
                onClicked: root.controller.closeIsland()
            }
        }

        Item {
            id: body
            anchors { top: header.bottom; bottom: navigation.top; left: parent.left; right: parent.right; margins: 14; topMargin: 10; bottomMargin: 10 }
            clip: true
        }

        Row {
            id: navigation
            anchors { bottom: parent.bottom; bottomMargin: 14; horizontalCenter: parent.horizontalCenter }
            spacing: 8
            Repeater {
                model: root.controller.pages
                IconButton {
                    required property var modelData
                    icon: modelData.icon
                    tooltip: modelData.title
                    checked: root.controller.pageId === modelData.key
                    onClicked: root.controller.selectPage(modelData.key)
                }
            }
        }
    }
}
