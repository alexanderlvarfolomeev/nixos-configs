pragma ComponentBehavior: Bound

import QtQuick
import qs.base as Base
import qs.services as Services
import qs.modules.island.components
import qs.modules.island.config

PageFrame {
    id: root
    title: "System"
    subtitle: "Session and machine"
    property var info: Services.SystemInfo {}

    Column {
        anchors.fill: parent
        spacing: 10
        Rectangle {
            width: parent.width
            height: 76
            radius: 16
            color: Theme.raised
            IconLabel {
                id: avatar
                anchors { left: parent.left; leftMargin: 16; verticalCenter: parent.verticalCenter }
                text: "account_circle"
                iconSize: 40
                color: Theme.accent
            }
            Column {
                anchors { left: avatar.right; right: parent.right; leftMargin: 14; rightMargin: 14; verticalCenter: parent.verticalCenter }
                spacing: 4
                Base.TextShadow {
                    text: root.info.user
                    width: parent.width
                    elide: Text.ElideRight
                    color: Theme.text
                    font { family: Theme.fontFamily; pixelSize: 17; weight: Font.DemiBold }
                }
                Base.TextShadow {
                    text: root.info.hostname
                    width: parent.width
                    elide: Text.ElideRight
                    color: Theme.textMuted
                    font { family: Theme.fontFamily; pixelSize: 11 }
                }
            }
        }
        Repeater {
            model: [
                { label: "Operating system", value: Services.OsInfo.prettyName },
                { label: "Desktop", value: root.info.desktop },
                { label: "Kernel", value: root.info.kernel },
                { label: "Uptime", value: root.info.uptimeLabel }
            ]
            Rectangle {
                required property var modelData
                width: parent.width
                height: 41
                radius: 10
                color: Theme.raised
                Base.TextShadow {
                    anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                    width: 130
                    text: parent.modelData.label
                    color: Theme.textMuted
                    font { family: Theme.fontFamily; pixelSize: 10 }
                }
                Base.TextShadow {
                    anchors { left: parent.left; right: parent.right; leftMargin: 144; rightMargin: 12; verticalCenter: parent.verticalCenter }
                    text: parent.modelData.value
                    elide: Text.ElideRight
                    color: Theme.text
                    font { family: Theme.fontFamily; pixelSize: 11 }
                }
            }
        }
    }
}
