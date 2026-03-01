pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import "../utils"

Singleton {
  id: root

  property var check: {
    console.log("Loaded!")
    40
  }

  // Hyprland.GlobalShortcut {
  //   name: "dashboard"
  //   appId: "quickshell"
  //   description: "Toggle Quickshell dashboard"
  //   // onPressed: console.log("Pressed!")
  // }
}