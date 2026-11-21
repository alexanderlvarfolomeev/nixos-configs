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
            property bool hoverExpanded: false
            readonly property bool expanded: pinned || hoverExpanded || collapseTimer.running
            readonly property int expandedWidth: page === "launcher" ? Theme.launcherWidth : Theme.controlWidth
            readonly property int expandedHeight: page === "launcher" ? Theme.launcherHeight : Theme.controlHeight
            readonly property int collapsedWidth: Math.min(compactContent.implicitWidth, screen.width - 24)
            readonly property int backingWidth: Math.max(collapsedWidth, Theme.controlWidth, Theme.launcherWidth)
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
                width: islandWindow.expanded ? islandWindow.expandedWidth : islandWindow.collapsedWidth
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
                            hoverExpandTimer.restart();
                        } else if (!islandWindow.pinned) {
                            hoverExpandTimer.stop();
                            if (islandWindow.hoverExpanded) {
                                if (islandWindow.autoCollapse) collapseTimer.restart();
                                else islandWindow.pinned = true;
                            }
                            islandWindow.hoverExpanded = false;
                        } else {
                            hoverExpandTimer.stop();
                            islandWindow.hoverExpanded = false;
                        }
                    }
                }

                CollapsedIsland {
                    id: compactContent
                    anchors.fill: parent
                    systemModel: root.systemState
                    page: islandWindow.page
                    expanded: islandWindow.expanded
                    onTogglePinned: islandWindow.pinned = !islandWindow.pinned
                }
                Loader {
                    anchors.fill: parent
                    enabled: islandWindow.expanded
                    active: islandWindow.expanded || contentUnload.running
                    sourceComponent: islandWindow.page === "launcher" ? launcherPage : controlPage
                    opacity: islandWindow.expanded ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 170; easing.type: Easing.OutQuad }
                    }
                }
            }

            // Give workspace tiles time to receive a click before expansion.
            Timer {
                id: hoverExpandTimer
                interval: 450
                onTriggered: islandWindow.hoverExpanded = islandHover.hovered
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
