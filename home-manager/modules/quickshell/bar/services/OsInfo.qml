pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string osLogo: "nix-snowflake"

    FileView {
        path: "/etc/os-release"
        onLoaded: {
            const match = text().match(/^LOGO=(?:"([^"]+)"|([^\r\n]+))/m);
            root.osLogo = match ? (match[1] || match[2]).trim() : "nix-snowflake";
        }
    }
}
