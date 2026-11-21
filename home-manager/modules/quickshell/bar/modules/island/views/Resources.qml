import QtQuick
import Quickshell
import qs.services
import qs.modules.island.components

PageFrame {
    id: root
    title: "Resources"
    subtitle: "Live system usage"
    property var monitor: ResourceMonitor {}

    Column {
        anchors.fill: parent
        spacing: 10
        MetricCard {
            width: parent.width
            height: (parent.height - 20) / 3
            icon: "memory"
            title: "CPU"
            value: root.monitor.cpuReady ? Math.round(root.monitor.cpuUsage * 100) + "%" : "Sampling…"
            detail: root.monitor.cpuName
            ratio: root.monitor.cpuUsage
            TapHandler { onTapped: Quickshell.execDetached(["auto-cpufreq-gtk"]) }
        }
        MetricCard {
            width: parent.width
            height: (parent.height - 20) / 3
            icon: "memory_alt"
            title: "Memory"
            ratio: root.monitor.ratio(root.monitor.memoryUsed, root.monitor.memoryTotal)
            value: root.monitor.memoryTotal > 0 ? Math.round(ratio * 100) + "%" : "Unavailable"
            detail: root.monitor.formatKib(root.monitor.memoryUsed) + " / " + root.monitor.formatKib(root.monitor.memoryTotal)
        }
        MetricCard {
            width: parent.width
            height: (parent.height - 20) / 3
            icon: "hard_drive"
            title: "Storage /"
            ratio: root.monitor.ratio(root.monitor.storageUsed, root.monitor.storageTotal)
            value: root.monitor.storageTotal > 0 ? Math.round(ratio * 100) + "%" : "Unavailable"
            detail: root.monitor.formatKib(root.monitor.storageUsed) + " / " + root.monitor.formatKib(root.monitor.storageTotal)
        }
    }
}
