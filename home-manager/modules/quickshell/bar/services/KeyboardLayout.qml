pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

/** Exposes the active Hyprland XKB keyboard layout name and code for indicators. */
Singleton {
    id: root
    property list<string> layoutCodes: []
    property var cachedLayoutCodes: ({})
    property string currentLayoutName: ""
    property string currentLayoutCode: ""
    property bool needsLayoutRefresh: false

    onCurrentLayoutNameChanged: root.updateLayoutCode()
    function updateLayoutCode() {
        if (!currentLayoutName) {
            root.currentLayoutCode = "";
        } else if (cachedLayoutCodes.hasOwnProperty(currentLayoutName)) {
            root.currentLayoutCode = cachedLayoutCodes[currentLayoutName];
        } else if (layoutCodes.length > 0) {
            root.currentLayoutCode = layoutCodes[0];
        }
    }

    function loadLayoutMappings(data) {
        const lines = data.split("\n");
        const mappings = {};
        let section = "";

        for (const line of lines) {
            const trimmed = line.trim();
            if (!trimmed) continue;

            if (trimmed.startsWith("!")) {
                section = trimmed.substring(1).trim().split(/\s+/)[0];
                continue;
            }

            if (section === "layout") {
                const match = line.match(/^\s*(\S+)\s+(.+)$/);
                if (match) mappings[match[2].trim()] = match[1];
            } else if (section === "variant") {
                const match = line.match(/^\s*(\S+)\s+(\S+):\s+(.+)$/);
                if (match) mappings[match[3].trim()] = match[2];
            }
        }

        root.cachedLayoutCodes = mappings;
        root.updateLayoutCode();
    }

    Process {
        id: layoutFile
        command: ["bash", Quickshell.shellPath("scripts/xkb_layouts.sh")]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.loadLayoutMappings(text)
        }
    }

    Process {
        id: fetchLayoutsProc
        running: true
        command: ["hyprctl", "-j", "devices"]

        stdout: StdioCollector {
            id: devicesCollector
            onStreamFinished: {
                try {
                    const parsedOutput = JSON.parse(devicesCollector.text);
                    const keyboards = parsedOutput.keyboards ?? [];
                    const hyprlandKeyboard = keyboards.find(kb => kb.main === true) ?? keyboards[0];
                    if (!hyprlandKeyboard) return;

                    root.layoutCodes = (hyprlandKeyboard.layout ?? "").split(",").filter(Boolean);
                    root.currentLayoutName = hyprlandKeyboard.active_keymap ?? "";
                } catch (error) {
                    console.warn("Failed to parse Hyprland keyboard data:", error);
                }
            }
        }

        onExited: {
            if (root.needsLayoutRefresh) {
                root.needsLayoutRefresh = false;
                fetchLayoutsProc.running = true;
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const dataString = event.data;
                root.currentLayoutName = dataString.substring(dataString.indexOf(",") + 1);
            } else if (event.name == "configreloaded") {
                if (fetchLayoutsProc.running) {
                    root.needsLayoutRefresh = true;
                } else {
                    fetchLayoutsProc.running = true;
                }
            }
        }
    }
}
