pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../utils"

Singleton {
  id: root

  property string linkedEmoji: "󰖪"
  property string ethernetEmoji: ""
  property string disconnectedEmoji: " "
  property var wifiEmoji: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]
  property string wlanId: "wlan0"

  property string state: "disconnected"
  property var network: null
  property var rssi: null
  property var ip4Adress: null

  Process {
    id: dateProc
    command: ["bash", "/home/aorise/nix/home-manager/modules/quickshell/bar/scripts/iwd_station_status.sh", wlanId]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        // console.log(this.text)
        let lines = this.text.split(/\n/)
        if (lines.length < 5 || !lines[0].includes("Station: " + wlanId)) {
            state = "disconnected"
            network = null
            rssi = null
            ip4Adress = null
        }
        // console.log(lines)
        let header = lines[2]
        let propertyOffset = header.indexOf("Property")
        let valueOffset = header.indexOf("Value")
        if (propertyOffset == -1 || valueOffset == -1 || propertyOffset >= valueOffset) {
            console.log("Malformed header line for station status: '" + header + "'")
            return
        }
        // console.log(propertyOffset + " " + valueOffset)
                    
        let properties = new Map();
        lines.slice(5).filter(l => l.length > 0).forEach(l => {
          let property = l.substring(propertyOffset, valueOffset).trim()
          let propertyValue = l.substring(valueOffset).trim()
          properties.set(property, propertyValue) 
        })
        state = properties.get("State")
        network = properties.get("Connected network") ?? null
        rssi = parseInt(properties.get("RSSI").split(/\s+/)[0]) ?? null
        ip4Adress = properties.get("IPv4 address") ?? null
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }

  function rssiLevel(dbm): real {
    let hardwareOptimum = -45
    let hardwareMin = -90.0
    let strength = 1.0 - Math.min(1.0, Math.abs(dbm - hardwareOptimum) / (hardwareOptimum - hardwareMin))
    return strength
  }

  function networkStateText(state, network, rssi): string {
    if (state == "disconnected") {
        return disconnectedEmoji
    } else if (state == "connected") {
        if (network == null) {
            return ethernetEmoji
        } else {
            return Visualization.getBinValue(wifiEmoji, rssiLevel(rssi))
        }
    } else {
        // TODO: understand all possible states 
        return linkedEmoji
    }
  }
}