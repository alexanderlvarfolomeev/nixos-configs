import QtQuick
import qs.config

Item {
    id: root

    required property var systemModel
    required property string page
    required property bool expanded
    signal togglePinned()

    implicitWidth: page === "control" ? workspaceStrip.implicitWidth + 24 : Theme.compactWidth
    implicitHeight: Theme.compactHeight
    visible: opacity > 0
    enabled: !root.expanded
    opacity: root.expanded ? 0 : 1

    Behavior on opacity { NumberAnimation { duration: 110 } }

    Flickable {
        anchors { fill: parent; leftMargin: 12; rightMargin: 12; topMargin: 2; bottomMargin: 2 }
        visible: root.page === "control"
        contentWidth: workspaceStrip.width
        contentHeight: height
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Workspaces {
            id: workspaceStrip
            height: parent.height
        }
    }

    Row {
        anchors.centerIn: parent
        visible: root.page !== "control"
        spacing: 9

        Row {
            id: workspacesRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 3
            Repeater {
                model: 3
                Rectangle {
                    required property int index
                    width: index === 0 ? 6 : 4
                    height: width
                    radius: width / 2
                    color: index === 0 ? Theme.accent : Theme.textMuted
                    opacity: 1 - index * 0.22
                }
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.systemModel.clock
            color: Theme.text
            font { family: Theme.monoFamily; pixelSize: 11; weight: Font.DemiBold }
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 14
            color: Theme.borderStrong
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.systemModel.keyboardLayout
            color: Theme.textMuted
            font { family: Theme.monoFamily; pixelSize: 10; weight: Font.DemiBold }
        }

        IconLabel {
            anchors.verticalCenter: parent.verticalCenter
            text: "wifi"
            iconSize: 15
            color: Theme.textMuted
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 1

            IconLabel {
                text: root.systemModel.batteryIcon
                iconSize: 16
                color: root.systemModel.batteryPercent > 0 && root.systemModel.batteryPercent < 20
                    ? Theme.warning
                    : Theme.textMuted
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: root.systemModel.batteryPercent > 0
                text: root.systemModel.batteryPercent + "%"
                color: Theme.textMuted
                font { family: Theme.monoFamily; pixelSize: 9 }
            }
        }
    }

    TapHandler {
        enabled: root.page !== "control"
        onTapped: root.togglePinned()
    }
}

