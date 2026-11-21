pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string osLogo: "nix-snowflake"
    property string prettyName: "Unknown Linux"

    FileView {
        path: "/etc/os-release"
        onLoaded: {
            const values = {};
            for (const line of text().split("\n")) {
                const match = line.match(/^([A-Z_]+)=(.*)$/);
                if (match) values[match[1]] = match[2].trim().replace(/^["']|["']$/g, "");
            }
            root.osLogo = values.LOGO || "nix-snowflake";
            root.prettyName = values.PRETTY_NAME || values.NAME || "Unknown Linux";
        }
    }
}
