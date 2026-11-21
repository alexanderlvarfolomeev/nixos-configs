import QtQuick

QtObject {
    id: root
    required property var registry
    property string pageId: registry?.defaultPage ?? "control"
    readonly property var currentPage: registry?.find(pageId) ?? null
    readonly property var pages: registry?.entries ?? []
    property bool expanded: false

    function selectPage(key) {
        if (!registry?.find(key)) {
            console.warn("Island: unknown page:", key);
            return false;
        }
        pageId = key;
        return true;
    }

    // Expansion is requested by the island/dashboard IPC handlers only.
    function openPage(key) {
        if (!selectPage(key)) return false;
        expanded = true;
        return true;
    }

    function closeIsland() { expanded = false; }
    function toggle() { expanded = !expanded; }
}
