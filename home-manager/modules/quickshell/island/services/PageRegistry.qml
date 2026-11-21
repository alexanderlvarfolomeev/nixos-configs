pragma ComponentBehavior: Bound

import QtQuick
import qs.components
import qs.config
import qs.views

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
        { key: "settings", title: "Settings", icon: "settings",
            width: Theme.settingsWidth, height: Theme.settingsHeight,
            keyboardFocus: true, view: settingsView, compactView: statusSummary }
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
    property Component settingsView: Component {
        Settings { controller: root.controller }
    }
    property Component workspaceSummary: Component { WorkspaceSummary {} }
    property Component statusSummary: Component {
        StatusSummary {
            systemModel: root.systemModel
            onTogglePinned: root.controller.toggle()
        }
    }
}
