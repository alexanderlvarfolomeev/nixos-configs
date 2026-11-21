import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    readonly property string user: Quickshell.env("USER") || "User"
    readonly property string desktop: Quickshell.env("XDG_CURRENT_DESKTOP") || "Unknown desktop"
    property string hostname: Quickshell.env("HOSTNAME") || ""
    property string kernel: "Unknown"
    property real uptimeSeconds: 0
    readonly property string uptimeLabel: {
        const days = Math.floor(uptimeSeconds / 86400);
        const hours = Math.floor(uptimeSeconds % 86400 / 3600);
        const minutes = Math.floor(uptimeSeconds % 3600 / 60);
        return (days > 0 ? days + "d " : "") + hours + "h " + minutes + "m";
    }
    property FileView hostnameFile: FileView {
        path: "/etc/hostname"
        onLoaded: root.hostname = text().trim()
    }
    property FileView kernelFile: FileView {
        path: "/proc/sys/kernel/osrelease"
        onLoaded: root.kernel = text().trim()
    }
    property FileView uptimeFile: FileView {
        path: "/proc/uptime"
        onLoaded: {
            const value = Number(text().trim().split(/\s+/)[0]);
            if (Number.isFinite(value)) root.uptimeSeconds = value;
        }
    }
    property Timer uptimeTimer: Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: root.uptimeFile.reload()
    }
}
