import QtQuick
import QtTest
import Quickshell
import qs.modules.island.components
import qs.modules.island.config

ShellRoot {
    id: root
    property int step: 0
    property var tile: null
    property color idle
    FloatingWindow {
        implicitWidth: 600
        implicitHeight: 120
        Workspaces { id: strip; x: 10; y: 10 }
    }
    TestCase { id: events; when: false }
    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            try {
                switch (root.step++) {
                case 0:
                    root.tile = events.findChild(strip, "workspace-2");
                    if (!root.tile || root.tile.modelData.apps.length !== 0) throw new Error("empty workspace fixture");
                    events.mouseMove(strip, strip.width + 20, 70);
                    break;
                case 1:
                    root.idle = root.tile.color;
                    events.mouseMove(root.tile, root.tile.width / 2, root.tile.height / 2);
                    break;
                case 2:
                    if (!Qt.colorEqual(root.tile.color, Theme.workspaceHover) || Qt.colorEqual(root.tile.color, root.idle))
                        throw new Error("empty workspace hover color");
                    events.mouseMove(strip, strip.width + 20, 70);
                    break;
                case 3:
                    if (!Qt.colorEqual(root.tile.color, root.idle)) throw new Error("hover exit restores color");
                    console.log("WORKSPACE_POINTER_CHECK_OK");
                    Qt.quit();
                }
            } catch (error) {
                console.error("WORKSPACE_POINTER_CHECK_FAILED", error);
                Qt.exit(1);
            }
        }
    }
}
