import QtQuick
import qs.base as Base
import Quickshell.Hyprland
import qs.modules.island.config
import qs.services

Row {
    id: root
    spacing: 3
    height: 32

    // Keep five numbered slots, plus any other existing/special workspaces.
    readonly property var workspaceModels: {
        const existing = Hyprland.workspaces.values;
        const windows = Hyprland.toplevels.values;
        const ids = new Set([1, 2, 3, 4, 5]);
        existing.forEach(workspace => ids.add(workspace.id));
        return Array.from(ids).sort((a, b) => a - b).map(id => {
            const workspace = existing.find(item => item.id === id);
            return {
                id: id,
                workspace: workspace,
                exists: workspace !== undefined,
                active: workspace?.focused ?? false,
                special: id < 0,
                apps: windows.filter(window => window.workspace?.id === id)
            };
        });
    }

    Rectangle { width: 5; height: root.height; color: Theme.workspaceActive }

    Repeater {
        model: root.workspaceModels

        Rectangle {
            id: tile
            required property var modelData
            width: workspaceRow.width + 20
            height: root.height
            radius: 5
            color: modelData.active ? Theme.workspaceActive
                : pointer.hovered ? Theme.workspaceHover
                : modelData.exists ? Theme.accentSoft : "transparent"

            Row {
                id: workspaceRow
                anchors.centerIn: parent
                spacing: 10

                Base.TextShadow {
                    anchors.verticalCenter: parent.verticalCenter
                    text: tile.modelData.special ? "S" : tile.modelData.id
                    color: tile.modelData.active ? Theme.activeText : Theme.accent
                    font { family: Theme.monoFamily; pixelSize: 24; bold: true }
                }

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: tile.modelData.apps.length > 0
                    width: appsRow.width + 16
                    height: 30
                    radius: 10
                    color: tile.modelData.active ? Theme.workspaceAppsActive : Theme.workspaceApps

                    Row {
                        id: appsRow
                        anchors.centerIn: parent
                        spacing: -6

                        Repeater {
                            model: tile.modelData.apps
                            ApplicationIcon {
                                required property var modelData
                                source: DesktopIcons.sourceFor(modelData)
                            }
                        }
                    }
                }
            }

            HoverHandler { id: pointer }
            TapHandler {
                onTapped: {
                    if (tile.modelData.active) return;
                    if (tile.modelData.workspace) tile.modelData.workspace.activate();
                    else Hyprland.dispatch('hl.dsp.focus({ workspace = "' + tile.modelData.id + '" })');
                }
            }
        }
    }

    Rectangle { width: 5; height: root.height; color: Theme.workspaceActive }
}
