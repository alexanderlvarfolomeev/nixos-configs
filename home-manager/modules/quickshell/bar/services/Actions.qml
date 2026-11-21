pragma Singleton

import Quickshell

Singleton {
    function toggleApplication(name) {
        Quickshell.execDetached(["bash", Quickshell.env("HOME") + "/.local/scripts/toggle.sh", name]);
    }
}
