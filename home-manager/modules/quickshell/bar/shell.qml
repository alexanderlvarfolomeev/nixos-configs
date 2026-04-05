//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
// TODO: try to parametrize
//@ pragma IconTheme default
//@ pragma Env QT_QUICK_WHEEL_DECELERATION=1000

// import "modules"
// import "modules/bar"
// import Quickshell

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.modules.dashboard as Dashboard
import qs.modules.devices as Devices
import qs.modules.general as General
import qs.modules.hyprland as Workspaces

// ShellRoot is the top-level container Quickshell expects
ShellRoot {
    id: root

    PanelWindow {
        id: panel
        visible: true
        color: Config.barColor

        implicitHeight: Config.barHeight

        anchors {
            top: true
            left: true
            right: true
        }

        exclusiveZone: height

        // // Background of the bar
        // Rectangle {
        //     anchors.fill: parent
        //     color: "#20242b"
        //     opacity: 0.15
        // }

        // Panel contents
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
                // Layout.alignment: Qt.AlignLeft
                

                General.Icon{}

                General.Time {}
            }

            Row {
                id: centerBlocks
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: parent.bottom
                }

                Workspaces.Workspaces {}
            }

            Row {
                id: rightBlocks
                spacing: 8
                anchors {
                    right: content.right
                    top: content.top
                    bottom: content.bottom
                }
                // Layout.alignment: Qt.AlignRight

                Devices.DeviceRow {}

                // Rectangle {
                //     anchors {
                //         top: rightBlocks.top
                //         bottom: rightBlocks.bottom
                //     }
                //     implicitWidth: 4
                //     color: "red"
                //     // Layout.fillHeight: true
                // }

                General.Language {}
        
                General.Power {}
            }
        }
    }

    Dashboard.Dash {
        anchorWindow: panel
    }
}
