pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "../utils"

Singleton {
    id: root

    property list<var> regexTitleToMap: [[/^Yazi/, "yazi"]]
    property list<var> regexToIgnore: [/^Alacritty/, /^ueberzugpp/, /^org.pulseaudio.pavucontrol$/]

    property int alwaysVisibleWorkspaces: 5
    property list<DesktopEntry> desktopEntries: DesktopEntries.applications.values
    property list<HyprlandWorkspace> occupiedWorkspaces: Hyprland.workspaces.values
    property list<HyprlandToplevel> topLevels: Hyprland.toplevels.values.filter(tl => tl.wayland != null && tl.workspace != null)
    property list<var> filteredTopLevels: filterApps(topLevels, regexTitleToMap, regexToIgnore)

    property list<var> workspaceModels: createModel(occupiedWorkspaces, filteredTopLevels, desktopEntries, alwaysVisibleWorkspaces)
    
    function guessIcon(appName): string {
        if (!appName || appName.length == 0) {
            return "image-missing"
        }

        let entry = DesktopEntries.byId(appName)
        if (entry != null) {
            return entry.icon
        }
        entry = DesktopEntries.heuristicLookup(appName)
        if (entry != null) {
            console.log("Heuristic match: " + appName)
            return entry.icon
        }

        console.log("No match: " + appName)
        return "image-missing"
    }

    function createModel(ws, tls, des, avw) {
        // console.log("Workspace model change triggered")
        let tpByW = new Map();
        tls.forEach(
            tl => {
                const wId = tl.workspace
                if (!tpByW.has(wId)) {
                    tpByW.set(wId, [])
                }
                tpByW.get(wId).push(tl.id)
            }
        )

        let resultMap = new Map();
        ws.forEach(
            w => resultMap.set(
                w.id, 
                {
                    id: w.id,
                    exists: true,
                    active: w.focused,
                    special: w.id < 0,
                    topLevels: tpByW.get(w.id) ?? [],
                },
            )
        )
        for (let idx = 1; idx <= avw; idx++) {
            if (!resultMap.has(idx)) {
                resultMap.set(
                    idx, 
                    {
                        id: idx,
                        exists: false,
                        active: false,
                        special: false,
                        topLevels: [],
                    },
                )
            }
        }
        return Array.from(resultMap.keys()).sort((a, b) => a - b).map(id => resultMap.get(id))
    }

    function filterApps(topLevels: list<HyprlandToplevel>, regexTitleToMap, regexToIgnore): list<var> {
        return topLevels.map(tl => filterApp(tl, regexTitleToMap, regexToIgnore)).filter(m => m != null)
    }

    function filterApp(topLevel: HyprlandToplevel, regexTitleToMap, regexToIgnore): var {
        let mappedAppId = null
        regexTitleToMap.forEach(
            p => {
                if (p[0].test(topLevel.title)) {
                    mappedAppId = p[1]
                }
            }
        )
        if (!mappedAppId) {
            mappedAppId = topLevel.wayland.appId ?? null
        }
        if(!mappedAppId || regexToIgnore.findIndex(regex => regex.test(mappedAppId)) >= 0) {
            return null
        } else {
            return {
                id: mappedAppId,
                title: topLevel.title,
                workspace: topLevel.workspace.id,
            }
        }
    }
}