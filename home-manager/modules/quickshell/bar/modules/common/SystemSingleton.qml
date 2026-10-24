pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// caelestia-dots SysInfo
Singleton {
  id: root

  property string user: Quickshell.env("USER")
  property string wm: Quickshell.env("XDG_CURRENT_DESKTOP")
  property string kernel
  property string kernelCustom
  property string osLogo: defaultOsLogo
  property string osName
  property string osPrettyName
  property string osId
  property string osVersionId
  property string uptimeString
  property string osNameString: {
    if (osVersionId.length != 0) {
      return `${osName} (${osVersionId})`;
    } else {
      return osName;
    }
  }

  readonly property string defaultOsLogo: "nix-snowflake"

  FileView {
    id: osRelease
    path: "/etc/os-release"

    onLoaded: {
      const pairs = text().split("\n").map(
        l => {
          const sepIdx = l.indexOf("=");
          if (sepIdx == -1 || sepIdx == l.length - 1) {
            return null;
          }
          const key = l.substring(0, sepIdx);
          let value = l.substring(sepIdx + 1).trim();
          if (value[0] == "\"") {
            value = value.substring(1, value.length - 1);
          }
          return [key, value];
        }
      ).filter(p => p !== null);
      const osMap = new Map(pairs);

      root.osLogo = osMap.get("LOGO") || root.defaultOsLogo;
      root.osName = osMap.get("NAME") || "";
      root.osPrettyName = osMap.get("PRETTY_NAME") || "";
      root.osId = osMap.get("ID") || "";
      root.osVersionId = osMap.get("VERSION_ID") || "";
    }
  }

  Timer {
    running: true
    repeat: true
    interval: 60000
    onTriggered: uptime.reload()
  }

  FileView {
    id: uptime
    path: "/proc/uptime"

    onLoaded: {
      const seconds = text().split(/\s+/)[0] ?? 0;
      const days = Math.floor(seconds / 86400);
      const hours = Math.floor((seconds % 86400) / 3600);
      const minutes = Math.floor((seconds % 3600) / 60);

      let str = "";
      if (days > 0)
        str += `${days} day${days === 1 ? "" : "s"}`;
      str += `${str ? ", " : ""}${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
      root.uptimeString = str;
    }
  }

  FileView {
    id: kernelRelease
    path: "/proc/sys/kernel/osrelease"

    onLoaded: {
      // split in case of custom kernel
      const data = text();
      const dash = data.indexOf('-');
      if (dash < 0) {
        root.kernel = data.trim();
      } else {
        root.kernel = data.substring(0, dash).trim();
        root.kernelCustom = data.substring(dash + 1).trim();
      }
    }
  }
}
