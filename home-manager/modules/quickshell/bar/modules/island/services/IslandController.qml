import QtQuick
import Quickshell
import qs.modules.island.config

Scope {
    id: root
    required property var registry

    property string pageId: registry?.defaultPage ?? "control"
    readonly property var currentPage: registry?.find(pageId) ?? null
    readonly property var pages: registry?.entries ?? []
    property bool pinned: false
    property bool hovered: false
    property bool hoverExpanded: false
    property bool suppressHover: false
    property bool autoCollapse: General.islandAutoCollapse
    property real panelOpacity: General.islandOpacity
    property real cornerRadius: Theme.cornerRadius
    readonly property int compactPreviewWidth: Theme.compactWidth
    readonly property bool expanded: pinned || hoverExpanded || collapseDelay.running

    function openPage(key) {
        if (!registry?.find(key)) {
            console.warn("Island: unknown page:", key);
            return false;
        }
        pageId = key;
        pinned = true;
        expandDelay.stop();
        collapseDelay.stop();
        return true;
    }

    function closeIsland() {
        // A close action must also work while the pointer is still inside.
        suppressHover = hovered;
        expandDelay.stop();
        pinned = false;
        hoverExpanded = false;
        collapseDelay.stop();
    }

    function toggle() {
        if (pinned) closeIsland();
        else openPage(pageId);
    }

    onHoveredChanged: {
        expandDelay.stop();
        if (hovered) {
            // Preserve expansion when re-entering during the collapse grace period.
            hoverExpanded = expanded;
            collapseDelay.stop();
            if (!suppressHover && !expanded) expandDelay.restart();
            return;
        }
        suppressHover = false;
        if (expanded && !pinned) {
            if (autoCollapse) collapseDelay.restart();
            else pinned = true;
        }
        hoverExpanded = false;
    }

    Timer {
        id: expandDelay
        interval: 450
        onTriggered: root.hoverExpanded = root.hovered && !root.suppressHover
    }
    Timer { id: collapseDelay; interval: 320 }
}
