pragma Singleton

import Quickshell

Singleton {
    id: root
    readonly property var entries: DesktopEntries.applications.values

    function normalized(value) {
        return String(value ?? "").replace(/\.desktop$/i, "").toLowerCase();
    }

    function entryFor(appId) {
        // Always subscribe to catalog changes, even if byId() succeeds early.
        // The desktop index and window metadata become available independently.
        const catalog = entries;
        if (!appId) return null;
        const key = normalized(appId);
        return DesktopEntries.byId(appId)
            ?? catalog.find(entry => normalized(entry.id) === key
                || normalized(entry.startupClass) === key)
            ?? DesktopEntries.heuristicLookup(appId);
    }

    function sourceFor(window) {
        const ipc = window.lastIpcObject ?? {};
        const candidates = [window.wayland?.appId, ipc.class, ipc.initialClass];
        // Terminal applications can supply a more specific title than their host.
        const titleMappings = [
            [/^Yazi/i, "yazi"], [/^Brogue/i, "brogue-ce"],
            [/^auto-cpufreq/i, "auto-cpufreq-gtk"]
        ];
        for (const [pattern, appId] of titleMappings) {
            if (pattern.test(window.title ?? "")) candidates.unshift(appId);
        }
        for (const candidate of candidates) {
            const entry = entryFor(candidate);
            const source = iconSource(entry?.icon ?? "");
            if (source) return source;
            // Some clients use the icon's theme name as their app id.
            if (candidate) {
                const themed = Quickshell.iconPath(candidate, true);
                if (themed) return themed;
            }
        }
        return "";
    }

    function iconSource(icon) {
        if (!icon) return "";
        if (icon.startsWith("/")) return "file://" + icon;
        if (/^[a-z][a-z0-9+.-]*:/i.test(icon)) return icon;
        return Quickshell.iconPath(icon, true);
    }
}
