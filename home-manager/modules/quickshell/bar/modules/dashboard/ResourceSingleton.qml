pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../utils/Utils.js" as Utils

// See caelestia-dots
Singleton {
  id: root

  property bool active: true

  property var disks: []
  readonly property real storageTotal: {
    let res = 0;
    for (const disk of disks) {
      res += disk.total
    }
    return res;
  }
  readonly property real storageUsed: {
    let res = 0;
    for (const disk of disks) {
      res += disk.used
    }
    return res;
  }
  readonly property real storagePercentage: Utils.percentage(storageUsed, storageTotal)

  property real memoryTotal
  property real memoryFree
  readonly property real memoryUsed: memoryTotal - memoryFree
  readonly property real memoryPercentage: Utils.percentage(memoryUsed, memoryTotal)

  property string cpuName: ""
  property real cpuTotal
  property real cpuIdle
  property real cpuPercentage
  // property var cpuByCoreUsage: null
  property real cpuTemp

  function cleanCpuName(name: string): string {
    return name
      .replace(/\(R\)|\(TM\)|CPU|\d+(?:th|nd|rd|st) Gen|Core|Processor/gi, "")
      .replace(/\s+/g, " ")
      .trim()
  }

  function formatKib(kib: real): var {
    const mib = 1024;
    const gib = 1024 ** 2;
    const tib = 1024 ** 3;

    if (kib >= tib)
      return {
        value: kib / tib,
        unit: "TiB"
      };
    if (kib >= gib)
      return {
        value: kib / gib,
        unit: "GiB"
      };
    if (kib >= mib)
      return {
        value: kib / mib,
        unit: "MiB"
      };
    return {
      value: kib,
      unit: "KiB"
    };
  }

  function kibToString(kib: real): string {
    const formattedKib = formatKib(kib);
    return formattedKib.value.toFixed(2) + " " + formattedKib.unit;
  }

  Timer {
    id: timer
    running: root.active
    interval: 5000
    repeat: true
    triggeredOnStart: true

    onTriggered: {
      console.log("Reloaded!")
      meminfo.reload()
      stat.reload()
      storage.running = true;
    }
  }

  FileView {
    id: cpuinfo
    path: "/proc/cpuinfo"
    
    onLoaded: {
      let nameMatch = text().match(/model name\s*:\s*(.+)/);
      if (nameMatch) {
        root.cpuName = cleanCpuName(nameMatch[1]);
      }
    }
  }

  FileView {
    id: meminfo
    path: "/proc/meminfo"
    
    onLoaded: {
      const data = text();
      // kB
      root.memoryFree = parseInt(data.match(/MemAvailable:\s*(\d+)/)[1], 10) || 1;
      root.memoryTotal = parseInt(data.match(/MemTotal:\s*(\d+)/)[1], 10) || 0;
    }
  }

  FileView {
    id: stat
    path: "/proc/stat"

    onLoaded: {
      const data = text();
      const cpuSummary = data.match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
      if (cpuSummary) {
        const stats = cpuSummary.slice(1).map(n => parseInt(n, 10));
        const total = stats.reduce((a, b) => a + b, 0);
        const idle = stats[3] + (stats[4] ?? 0);

        const totalDiff = total - root.cpuTotal;
        const idleDiff = idle - root.cpuIdle;
        cpuPercentage = Utils.percentage(totalDiff - idleDiff, totalDiff);

        root.cpuTotal = total;
        root.cpuIdle = idle;
      }
    }
  }

  Process {
    id: storage

    // Get physical disks with aggregated usage from their partitions
    // -J triggers JSON output. -b triggers bytes.
    command: ["lsblk", "-J", "-b", "-o", "NAME,SIZE,TYPE,FSUSED,FSSIZE,MOUNTPOINT"]

    stdout: StdioCollector {
      onStreamFinished: {
        const data = JSON.parse(text);
        const diskList = [];
        const seenDevices = new Set();

        // Helper to recursively sum usage from children (partitions, crypt, lvm)
        const aggregateUsage = dev => {
          let used = 0;
          let size = 0;
          let isRoot = dev.mountpoint === "/" || (dev.mountpoints && dev.mountpoints.includes("/"));

          if (!seenDevices.has(dev.name)) {
            // lsblk returns null for empty/unformatted partitions, which parses to 0 here
            used = parseInt(dev.fsused) || 0;
            size = parseInt(dev.fssize) || 0;
            seenDevices.add(dev.name);
          }

          if (dev.children) {
            for (const child of dev.children) {
              const stats = aggregateUsage(child);
              used += stats.used;
              size += stats.size;
              if (stats.isRoot)
                isRoot = true;
            }
          }
          return {
            used,
            size,
            isRoot
          };
        };

        for (const dev of data.blockdevices) {
          // Only process physical disks at the top level
          if (dev.type === "disk" && !dev.name.startsWith("zram")) {
            const stats = aggregateUsage(dev);

            if (stats.size === 0) {
              continue;
            }

            const total = stats.size;
            const used = stats.used;

            diskList.push({
              mount: dev.name,
              used: used / 1024      // KiB
              ,
              total: total / 1024    // KiB
              ,
              free: (total - used) / 1024,
              perc: total > 0 ? used / total : 0,
              hasRoot: stats.isRoot
            });
          }
        }

        // Sort by putting the disk with root first, then sort the rest alphabetically
        root.disks = diskList.sort((a, b) => {
            if (a.hasRoot && !b.hasRoot)
              return -1;
            if (!a.hasRoot && b.hasRoot)
              return 1;
            return a.mount.localeCompare(b.mount);
        });
      }
    }
  }
}