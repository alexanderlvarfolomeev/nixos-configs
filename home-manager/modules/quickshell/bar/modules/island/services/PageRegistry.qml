pragma ComponentBehavior: Bound

import QtQuick
import qs.modules.island.components
import qs.modules.island.config
import qs.modules.island.views

QtObject {
    id: root
    required property var systemModel
    required property var controller

    readonly property string defaultPage: "control"
    // This is the only list to extend when adding a page.
    readonly property var entries: [
        { key: "control", title: "Control Center", icon: "tune",
            width: Theme.controlWidth, height: Theme.controlHeight,
            keyboardFocus: false, view: controlView, compactView: workspaceSummary },
        { key: "launcher", title: "Launcher", icon: "search",
            width: Theme.launcherWidth, height: Theme.launcherHeight,
            keyboardFocus: true, view: launcherView, compactView: statusSummary },
        { key: "media", title: "Media", icon: "music_note",
            width: 430, height: 450,
            keyboardFocus: false, view: mediaView, compactView: statusSummary },
        { key: "resources", title: "Resources", icon: "monitoring",
            width: 430, height: 400,
            keyboardFocus: false, view: resourcesView, compactView: workspaceSummary },
        { key: "system", title: "System", icon: "person",
            width: 430, height: 430,
            keyboardFocus: false, view: systemView, compactView: statusSummary }
    ]
    readonly property int maximumWidth: Math.max(...entries.map(page => page.width))
    readonly property int maximumHeight: Math.max(...entries.map(page => page.height))

    function find(key) {
        return entries.find(page => page.key === key) ?? null;
    }

    property Component controlView: Component {
        ControlCenter { systemModel: root.systemModel; controller: root.controller }
    }
    property Component launcherView: Component {
        Launcher { controller: root.controller }
    }
    property Component mediaView: Component { Media { controller: root.controller } }
    property Component resourcesView: Component { Resources { controller: root.controller } }
    property Component systemView: Component { SystemInfo { controller: root.controller } }
    property Component workspaceSummary: Component { WorkspaceSummary {} }
    property Component statusSummary: Component {
        StatusSummary {
            systemModel: root.systemModel
        }
    }
}
