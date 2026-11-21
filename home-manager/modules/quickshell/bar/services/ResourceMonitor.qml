import QtQuick
import Quickshell.Io

QtObject {
    id: root
    // Instances belong to loaded resource pages; destruction stops every timer.
    property real cpuUsage: 0
    property bool cpuReady: false
    property string cpuName: "CPU"
    property real previousTotal: 0
    property real previousIdle: 0
    property real memoryTotal: 0
    property real memoryUsed: 0
    property real storageTotal: 0
    property real storageUsed: 0

    function ratio(used, total) { return total > 0 ? Math.max(0, Math.min(1, used / total)) : 0; }
    function formatKib(value) { return value >= 1048576 ? (value / 1048576).toFixed(1) + " GiB" : (value / 1024).toFixed(0) + " MiB"; }

    function updateCpu(data) {
        const match = data.match(/^cpu\s+(.+)$/m);
        if (!match) return;
        // Guest time is already included in user/nice; do not count it twice.
        const times = match[1].trim().split(/\s+/).slice(0, 8).map(Number);
        if (times.length < 4 || !times.every(Number.isFinite)) return;
        const total = times.reduce((sum, value) => sum + value, 0);
        const idle = times[3] + (times[4] ?? 0);
        if (previousTotal > 0 && total > previousTotal && idle >= previousIdle) {
            cpuUsage = ratio((total - previousTotal) - (idle - previousIdle), total - previousTotal);
            cpuReady = true;
        }
        previousTotal = total;
        previousIdle = idle;
    }

    function updateMemory(data) {
        const total = data.match(/^MemTotal:\s+(\d+)/m);
        const available = data.match(/^MemAvailable:\s+(\d+)/m);
        if (!total || !available) return;
        memoryTotal = Number(total[1]);
        memoryUsed = Math.max(0, memoryTotal - Number(available[1]));
    }

    property FileView cpuInfo: FileView {
        path: "/proc/cpuinfo"
        onLoaded: {
            const match = text().match(/^(?:model name|Hardware)\s*:\s*(.+)$/m);
            if (match) root.cpuName = match[1].trim();
        }
    }
    property FileView cpu: FileView {
        path: "/proc/stat"
        onLoaded: root.updateCpu(text())
    }
    property FileView memory: FileView {
        path: "/proc/meminfo"
        onLoaded: root.updateMemory(text())
    }
    property Timer sampleTimer: Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: { root.cpu.reload(); root.memory.reload(); }
    }
    property Process storage: Process {
        command: ["df", "-kP", "/"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const row = text.trim().split("\n").pop().trim().split(/\s+/);
                const total = Number(row[1]);
                const used = Number(row[2]);
                if (Number.isFinite(total) && Number.isFinite(used)) {
                    root.storageTotal = total;
                    root.storageUsed = used;
                }
            }
        }
    }
    property Timer storageTimer: Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: { if (!root.storage.running) root.storage.running = true; }
    }
}
