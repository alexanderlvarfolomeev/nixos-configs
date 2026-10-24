pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    // TODO: map neovim window to "nvim"
    readonly property list<var> regexTitleToMap: [[/^Yazi/, "yazi"], [/^Brogue/, "brogue-ce"], [/^auto-cpufreq/, "auto-cpufreq-gtk"]]
    readonly property list<var> regexToIgnore: [/^Alacritty/, /^ueberzugpp/, /^org.pulseaudio.pavucontrol$/, /^com.gabm.satty/, /^foot/]
    property var iconCache: ({})

    property int alwaysVisibleWorkspaces: 5
    property list<HyprlandWorkspace> occupiedWorkspaces: Hyprland.workspaces.values
    property list<HyprlandToplevel> topLevels: Hyprland.toplevels.values.filter(tl => tl.wayland != null && tl.workspace != null)
    property list<var> filteredTopLevels: filterApps(topLevels, regexTitleToMap, regexToIgnore)

    property list<var> workspaceModels: createModel(occupiedWorkspaces, filteredTopLevels, alwaysVisibleWorkspaces)

    function guessIcon(appName): string {
        if (!appName || appName.length == 0) {
            return "image-missing";
        }

        if (iconCache.hasOwnProperty(appName)) {
            return iconCache[appName];
        }

        let entry = DesktopEntries.byId(appName);
        if (entry == null) entry = DesktopEntries.heuristicLookup(appName);

        const icon = entry?.icon || "image-missing";
        iconCache[appName] = icon;
        return icon;
    }

    function createModel(ws, tls, avw) {
        let tpByW = new Map();
        tls.forEach(tl => {
            const wId = tl.workspace;
            if (!tpByW.has(wId)) {
                tpByW.set(wId, []);
            }
            tpByW.get(wId).push(tl.id);
        });

        let resultMap = new Map();
        ws.forEach(w => resultMap.set(w.id, {
                id: w.id,
                workspace: w,
                exists: true,
                active: w.focused,
                special: w.id < 0,
                topLevels: tpByW.get(w.id) ?? []
            }));
        for (let idx = 1; idx <= avw; idx++) {
            if (!resultMap.has(idx)) {
                resultMap.set(idx, {
                    id: idx,
                    exists: false,
                    active: false,
                    special: false,
                    topLevels: [],
                    workspace: {
                        activate: () => Hyprland.dispatch(`hl.dsp.focus({ workspace = "${idx}" })`)
                    }
                });
            }
        }
        return Array.from(resultMap.keys()).sort((a, b) => a - b).map(id => resultMap.get(id));
    }

    function filterApps(topLevels: list<HyprlandToplevel>, regexTitleToMap, regexToIgnore): list<var> {
        return topLevels.map(tl => filterApp(tl, regexTitleToMap, regexToIgnore)).filter(m => m != null);
    }

    function filterApp(topLevel: HyprlandToplevel, regexTitleToMap, regexToIgnore): var {
        let mappedAppId = null;
        for (const p of regexTitleToMap) {
            if (p[0].test(topLevel.title)) {
                mappedAppId = p[1];
                break;
            }
        }
        if (!mappedAppId) {
            mappedAppId = topLevel.wayland.appId ?? null;
        }
        if (!mappedAppId || regexToIgnore.findIndex(regex => regex.test(mappedAppId)) >= 0) {
            return null;
        } else {
            return {
                key: topLevel.id,
                id: mappedAppId,
                title: topLevel.title,
                workspace: topLevel.workspace.id
            };
        }
    }
}
