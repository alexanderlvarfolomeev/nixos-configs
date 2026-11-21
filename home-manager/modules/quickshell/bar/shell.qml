//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme default
//@ pragma Env QT_QUICK_WHEEL_DECELERATION=1000

import QtQuick
import Quickshell
import qs.config
import qs.modules.island as Island
import qs.modules.devices as Devices
import qs.modules.general as General

ShellRoot {
    id: root

    Variants {
        id: panels
        model: Quickshell.screens

        PanelWindow {
            id: panel
            required property var modelData

            screen: modelData
            visible: true
            color: Config.barColor

            implicitHeight: Config.barHeight

            anchors {
                top: true
                left: true
                right: true
            }

            exclusiveZone: height

            Rectangle {
                id: content
                anchors.fill: parent
                color: "transparent"

                Row {
                    id: leftBlocks
                    spacing: 20
                    anchors {
                        left: content.left
                        top: content.top
                        bottom: content.bottom
                        leftMargin: 8.0
                    }

                    General.Icon {}

                    General.Time {}
                }

                Row {
                    id: rightBlocks
                    spacing: 8
                    anchors {
                        right: content.right
                        top: content.top
                        bottom: content.bottom
                    }

                    Devices.DeviceRow {}

                    General.Language {}

                    General.Power {}
                }
            }
        }
    }

    Island.Island {
        barHeight: Config.barHeight
    }
}
