pragma ComponentBehavior: Bound

import QtQuick
import qs.base as Base
import Quickshell
import qs.modules.island.components
import qs.modules.island.config

PageFrame {
    id: root

    required property var systemModel
    title: "Control Center"
    subtitle: systemModel.dateLabel

    Column {
        anchors {
            fill: parent
        }
        spacing: 8

        Grid {
            width: parent.width
            height: 120
            columns: 2
            rows: 2
            columnSpacing: 8
            rowSpacing: 8

            ToggleTile {
                width: (parent.width - 8) / 2
                height: 56
                icon: "wifi"
                title: "Wi-Fi"
                subtitle: "Open networks"
                onClicked: root.systemModel.openNetwork()
            }

            ToggleTile {
                width: (parent.width - 8) / 2
                height: 56
                icon: root.systemModel.bluetoothEnabled ? "bluetooth_connected" : "bluetooth_disabled"
                title: "Bluetooth"
                subtitle: root.systemModel.bluetoothEnabled ? "On" : "Off"
                active: root.systemModel.bluetoothEnabled
                onClicked: root.systemModel.toggleBluetooth()
            }

            ToggleTile {
                width: (parent.width - 8) / 2
                height: 56
                icon: "do_not_disturb_on"
                title: "Focus"
                subtitle: root.systemModel.doNotDisturb ? "Notifications paused" : "Available"
                active: root.systemModel.doNotDisturb
                onClicked: root.systemModel.toggleDoNotDisturb()
            }

            ToggleTile {
                width: (parent.width - 8) / 2
                height: 56
                icon: "sports_esports"
                title: "Game Mode"
                subtitle: root.systemModel.gameMode ? "Animations off" : "Ready"
                active: root.systemModel.gameMode
                onClicked: root.systemModel.toggleGameMode()
            }
        }

        Rectangle {
            width: parent.width
            height: 86
            radius: 15
            color: Theme.raised
            border.color: Theme.border
            border.width: 1

            Column {
                anchors {
                    fill: parent
                    leftMargin: 11
                    rightMargin: 11
                    topMargin: 5
                    bottomMargin: 5
                }

                SliderRow {
                    width: parent.width
                    icon: root.systemModel.muted ? "volume_off" : "volume_up"
                    label: "Sound"
                    value: root.systemModel.volume
                    onValueMoved: value => root.systemModel.setVolume(value)
                }

                SliderRow {
                    width: parent.width
                    icon: "brightness_6"
                    label: "Display"
                    value: root.systemModel.brightness
                    onValueMoved: value => root.systemModel.setBrightness(value)
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 64
            radius: 15
            color: Theme.raised
            border.color: Theme.border
            border.width: 1

            Row {
                anchors {
                    fill: parent
                    margins: 11
                }
                spacing: 10

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 34
                    height: 34
                    radius: 17
                    color: Theme.accentSoft

                    IconLabel {
                        anchors.centerIn: parent
                        text: "notifications"
                        iconSize: 19
                        color: Theme.accent
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - 84
                    spacing: 1

                    Base.TextShadow {
                        text: "Notifications"
                        color: Theme.text
                        font { family: Theme.fontFamily; pixelSize: 12; weight: Font.DemiBold }
                    }
                    Base.TextShadow {
                        text: root.systemModel.doNotDisturb ? "Do not disturb is enabled" : "Open notification center"
                        color: Theme.textMuted
                        font { family: Theme.fontFamily; pixelSize: 9 }
                    }
                }

                IconLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 20
                    text: "chevron_right"
                    color: Theme.textMuted
                }
            }

            TapHandler { onTapped: Quickshell.execDetached(["swaync-client", "-t"]) }
        }

    }
}
