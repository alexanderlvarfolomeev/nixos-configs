pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  function getBinValue(bins, ratio): var {
    let bin = Math.min(bins.length - 1, Math.floor(ratio * bins.length))
    return bins[bin]
  }  
}