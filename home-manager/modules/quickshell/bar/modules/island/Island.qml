import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.island.components
import qs.modules.island.config
import qs.modules.island.services
import qs.services

Scope {
    id: root
    required property int barHeight
    readonly property int topMargin: Math.max(0, (barHeight - Theme.compactHeight) / 2)

    Variants {
        id: islandInstances
        model: Quickshell.screens

        PanelWindow {
            id: islandWindow
            required property var modelData

            property var controller: IslandController {
                id: state
                registry: pageRegistry
            }
            property var registry: PageRegistry {
                id: pageRegistry
                systemModel: SystemState
                controller: state
            }
            readonly property int collapsedWidth: Math.min(compactContent.implicitWidth, screen.width - 24)
            readonly property int backingWidth: Math.max(collapsedWidth, pageRegistry.maximumWidth)
            readonly property int backingHeight: Math.max(Theme.compactHeight, pageRegistry.maximumHeight)

            screen: modelData
            visible: true
            aboveWindows: true
            focusable: state.expanded && state.currentPage.keyboardFocus
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
            margins.top: root.topMargin

            Rectangle {
                id: islandSurface
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                width: state.expanded ? state.currentPage.width : islandWindow.collapsedWidth
                height: state.expanded ? state.currentPage.height : Theme.compactHeight
                clip: true
                radius: state.expanded ? Theme.cornerRadius : height / 2
                color: Qt.rgba(
                    Theme.background.r,
                    Theme.background.g,
                    Theme.background.b,
                    General.islandOpacity
                )
                border.color: state.expanded ? Theme.borderStrong : Theme.border
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

                CollapsedIsland {
                    id: compactContent
                    anchors.fill: parent
                    sourceComponent: state.currentPage.compactView
                    expanded: state.expanded
                }
                Loader {
                    anchors.fill: parent
                    enabled: state.expanded
                    active: state.expanded || contentUnload.running
                    sourceComponent: state.currentPage.view
                    opacity: state.expanded ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 170; easing.type: Easing.OutQuad }
                    }
                }
            }

            Timer {
                id: contentUnload
                interval: Theme.animationDuration + 100
                repeat: false
                onTriggered: state.pageId = pageRegistry.defaultPage
            }

            Connections {
                target: state
                function onExpandedChanged() {
                    if (state.expanded) {
                        contentUnload.stop();
                        SystemState.refreshControls();
                    }
                    else contentUnload.restart();
                }
            }
        }
    }

    IpcHandler {
        target: "island"

        function toggle() {
            for (const instance of islandInstances.instances) instance.controller.toggle();
        }

        function controlCenter() {
            for (const instance of islandInstances.instances) instance.controller.openPage("control");
        }

        function launcher() {
            for (const instance of islandInstances.instances) instance.controller.openPage("launcher");
        }

        function open(page: string) {
            for (const instance of islandInstances.instances) instance.controller.openPage(page);
        }

        function close() {
            for (const instance of islandInstances.instances) instance.controller.closeIsland();
        }
    }

    // Preserve qsbar's existing Super+D binding and dashboard IPC clients.
    IpcHandler {
        target: "dashboard"
        function toggle() {
            for (const instance of islandInstances.instances) instance.controller.toggle();
        }
    }

}
