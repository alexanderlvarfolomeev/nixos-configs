pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.utils

Singleton {
  id: root

  property string linkedEmoji: "󰖪"
  property string ethernetEmoji: ""
  property string disconnectedEmoji: " "
  property var wifiEmoji: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]
  // Leave empty to discover the first wireless interface from sysfs.
  property string wlanId: ""

  property string state: "disconnected"
  property var network: null
  property var rssi: null
  property var ip4Address: null

  function resetState() {
    state = "disconnected"
    network = null
    rssi = null
    ip4Address = null
  }

  Process {
    id: stationProc
    command: [Quickshell.shellPath("scripts/iwd_station_status.sh"), wlanId]
    running: true

    onExited: (exitCode, exitStatus) => {
      if (exitCode !== 0) {
        root.resetState()
      }
    }

    stdout: StdioCollector {
      onStreamFinished: {
        const lines = this.text.split(/\n/)
        const stationLine = lines.find(line => line.includes("Station:"))
        const header = lines.find(line => line.includes("Property") && line.includes("Value"))

        if (!stationLine || !header) {
          root.resetState()
          return
        }

        const propertyOffset = header.indexOf("Property")
        const valueOffset = header.indexOf("Value")
        if (propertyOffset == -1 || valueOffset == -1 || propertyOffset >= valueOffset) {
          root.resetState()
          return
        }

        const properties = new Map()
        lines.filter(line => line.length >= valueOffset).forEach(line => {
          const property = line.substring(propertyOffset, valueOffset).trim()
          const propertyValue = line.substring(valueOffset).trim()
          if (property && property !== "Property") {
            properties.set(property, propertyValue)
          }
        })

        const parsedRssi = Number.parseInt((properties.get("RSSI") ?? "").split(/\s+/)[0], 10)
        root.state = properties.get("State") ?? "disconnected"
        root.network = properties.get("Connected network") ?? null
        root.rssi = Number.isFinite(parsedRssi) ? parsedRssi : null
        root.ip4Address = properties.get("IPv4 address") ?? null
      }
    }
  }

  Timer {
    interval: 10000
    running: true
    repeat: true
    onTriggered: {
      if (!stationProc.running) {
        stationProc.running = true
      }
    }
  }

  function rssiLevel(dbm): real {
    if (!Number.isFinite(dbm)) {
      return 0
    }
    let hardwareOptimum = -45
    let hardwareMin = -90.0
    return Math.max(0, 1.0 - Math.min(1.0, Math.abs(dbm - hardwareOptimum) / (hardwareOptimum - hardwareMin)))
  }

  function networkStateText(state, network, rssi): string {
    if (state == "disconnected") {
        return disconnectedEmoji
    } else if (state == "connected") {
        if (network == null) {
            return ethernetEmoji
        } else {
            return Utils.getBinValue(wifiEmoji, rssiLevel(rssi))
        }
    } else {
        // TODO: understand all possible states 
        return linkedEmoji
    }
  }
}
