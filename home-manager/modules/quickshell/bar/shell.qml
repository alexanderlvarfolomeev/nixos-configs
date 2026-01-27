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
import "modules/blocks" as Blocks
// import "modules/dashboard" as Dashboard
import "modules/devices" as Devices
import "modules/general" as General
import "modules/workspaces" as Workspaces

// ShellRoot is the top-level container Quickshell expects
ShellRoot {
    id: root

    // One panel window
    PanelWindow {
        id: panel
        visible: true
        color: "#2620242b"

        // Size of the bar (thickness)
        implicitHeight: 40

        // Anchor to the top of the screen and stretch horizontally
        // PanelWindow already knows how to span the selected output width.
        anchors {
            top: true
            left: true
            right: true
        }

        // Reserve space so other windows don't overlap
        // If your Quickshell version doesn't have exclusiveZone, use: reserveSpace: true
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
            // Layout.fillHeight: true
            // Layout.fillWidth: true
            // spacing: 0

            // Blocks.Time{}

            // // Spacer to push future widgets to the right if you add them
            // Item { Layout.fillWidth: true }

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

                // Rectangle {
                //     implicitWidth: 4
                //     implicitHeight: parent.implicitHeight
                //     color: "transparent"
                // }

                General.Time {}
            }

            Row {
                id: centerBlocks
                anchors.centerIn: parent
                height: parent.height

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

                Blocks.Language {}
        
                General.Power {}
            }
        }
    }

    // Dashboard.Dash {
    //     anchorWindow: panel
    // }
}
