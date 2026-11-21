//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme default

import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.config
import qs.services
import qs.views

ShellRoot {
    id: root

    property var systemState: SystemState { id: systemModel }

    Variants {
        id: islandInstances
        model: Quickshell.screens

        PanelWindow {
            id: islandWindow
            required property var modelData

            property string page: "control"
            property bool pinned: false
            property bool autoCollapse: General.islandAutoCollapse
            property real panelOpacity: General.islandOpacity
            property real cornerRadius: Theme.cornerRadius
            readonly property int compactPreviewWidth: Theme.compactWidth
            readonly property bool expanded: pinned || islandHover.hovered || collapseTimer.running
            readonly property int expandedWidth: page === "launcher" ? Theme.launcherWidth : Theme.controlWidth
            readonly property int expandedHeight: page === "launcher" ? Theme.launcherHeight : Theme.controlHeight
            readonly property int backingWidth: Math.max(Theme.compactWidth, Theme.controlWidth, Theme.launcherWidth)
            readonly property int backingHeight: Math.max(Theme.compactHeight, Theme.controlHeight, Theme.launcherHeight)

            function openPage(nextPage) {
                page = nextPage;
                pinned = true;
                collapseTimer.stop();
            }

            function closeIsland() {
                pinned = false;
                page = "control";
                collapseTimer.stop();
            }

            screen: modelData
            visible: true
            aboveWindows: true
            focusable: expanded && (page === "launcher")
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            surfaceFormat.opaque: false

            // Keep the Wayland backing buffer stable. Resizing a layer-shell
            // window is asynchronous, which can expose a stale/unpainted strip
            // between the requested and compositor-confirmed dimensions.
            implicitWidth: backingWidth
            implicitHeight: backingHeight

            // Only the visible island accepts input; the rest of the fixed,
            // transparent backing window remains click-through.
            mask: Region {
                item: islandSurface
                radius: islandSurface.radius
            }

            anchors.top: true
            margins.top: 3

            Rectangle {
                id: islandSurface
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                width: islandWindow.expanded ? islandWindow.expandedWidth : Theme.compactWidth
                height: islandWindow.expanded ? islandWindow.expandedHeight : Theme.compactHeight
                clip: true
                radius: islandWindow.expanded ? islandWindow.cornerRadius : height / 2
                color: Qt.rgba(
                    Theme.background.r,
                    Theme.background.g,
                    Theme.background.b,
                    islandWindow.panelOpacity
                )
                border.color: islandWindow.expanded ? Theme.borderStrong : Theme.border
                border.width: 1

                Behavior on width {
                    NumberAnimation {
                        duration: Theme.animationDuration
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: Theme.animationDuration
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on radius {
                    NumberAnimation {
                        duration: Theme.animationDuration
                    }
                }

                HoverHandler {
                    id: islandHover

                    onHoveredChanged: {
                        if (hovered) {
                            collapseTimer.stop();
                        } else if (!islandWindow.pinned) {
                            if (islandWindow.autoCollapse) collapseTimer.restart();
                            else islandWindow.pinned = true;
                        }
                    }
                }

                Item {
                    id: compactContent
                    anchors.fill: parent
                    visible: opacity > 0
                    opacity: islandWindow.expanded ? 0 : 1

                    Behavior on opacity { NumberAnimation { duration: 110 } }

                    Row {
                        anchors.centerIn: parent
                        spacing: 9

                        Row {
                            id: workspacesRow
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 3
                            Repeater {
                                model: 3
                                Rectangle {
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
                            text: systemModel.clock
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
                            text: systemModel.keyboardLayout
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
                                text: systemModel.batteryIcon
                                iconSize: 16
                                color: systemModel.batteryPercent > 0 && systemModel.batteryPercent < 20
                                    ? Theme.warning
                                    : Theme.textMuted
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                visible: systemModel.batteryPercent > 0
                                text: systemModel.batteryPercent + "%"
                                color: Theme.textMuted
                                font { family: Theme.monoFamily; pixelSize: 9 }
                            }
                        }
                    }

                    TapHandler { onTapped: islandWindow.pinned = !islandWindow.pinned }
                }

                Loader {
                    anchors.fill: parent
                    active: islandWindow.expanded || contentUnload.running
                    sourceComponent: islandWindow.page === "launcher" ? launcherPage : controlPage
                    opacity: islandWindow.expanded ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 170; easing.type: Easing.OutQuad }
                    }
                }
            }

            Timer {
                id: collapseTimer
                interval: 320
                repeat: false
                onTriggered: islandWindow.page = "control"
            }

            Timer {
                id: contentUnload
                interval: Theme.animationDuration + 100
                repeat: false
            }

            onExpandedChanged: {
                if (expanded) contentUnload.stop();
                else contentUnload.restart();
            }

            Component {
                id: controlPage
                ControlCenter {
                    systemModel: root.systemState
                    controller: islandWindow
                }
            }

            Component {
                id: launcherPage
                Launcher { controller: islandWindow }
            }
        }
    }

    IpcHandler {
        target: "island"

        function toggle() {
            for (const instance of islandInstances.instances) instance.pinned = !instance.pinned;
        }

        function controlCenter() {
            for (const instance of islandInstances.instances) instance.openPage("control");
        }

        function launcher() {
            for (const instance of islandInstances.instances) instance.openPage("launcher");
        }

        function close() {
            for (const instance of islandInstances.instances) instance.closeIsland();
        }
    }

}
