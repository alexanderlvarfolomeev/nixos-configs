pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth as BT
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property date now: Clock.date
    readonly property string clock: Clock.time
    readonly property string dateLabel: Qt.formatDate(now, "ddd, d MMM")

    readonly property var sink: Audio.sink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? false

    readonly property var bluetoothAdapter: BT.Bluetooth.defaultAdapter
    readonly property bool bluetoothEnabled: bluetoothAdapter?.enabled ?? false

    readonly property int batteryPercent: Math.round((UPower.displayDevice?.percentage ?? 0) * 100)
    readonly property bool charging: UPower.displayDevice?.state === UPowerDeviceState.Charging
    readonly property string batteryIcon: {
        if (charging) return "battery_charging_full";
        if (batteryPercent >= 85) return "battery_full";
        if (batteryPercent >= 55) return "battery_5_bar";
        if (batteryPercent >= 25) return "battery_3_bar";
        return "battery_1_bar";
    }

    property real brightness: 0.65
    property bool brightnessWritePending: false
    property bool doNotDisturb: false
    property bool gameMode: false
    property var savedAnimationValue: null
    property var queriedAnimationValue: null
    property bool requestedGameMode: false
    readonly property string keyboardLayout: KeyboardLayout.currentLayoutCode.toUpperCase() || "--"

    function setVolume(nextVolume) {
        if (!sink?.audio) return;
        if (!Number.isFinite(nextVolume)) return;
        sink.audio.volume = Math.max(0, Math.min(1, nextVolume));
    }

    function toggleMute() {
        if (sink?.audio) sink.audio.muted = !sink.audio.muted;
    }

    function setBrightness(nextBrightness) {
        if (!Number.isFinite(nextBrightness)) return;
        brightness = Math.max(0.01, Math.min(1, nextBrightness));
        brightnessWritePending = true;
        if (!brightnessThrottle.running) brightnessThrottle.start();
    }

    function toggleBluetooth() {
        Quickshell.execDetached(["bluetoothctl", "power", bluetoothEnabled ? "off" : "on"]);
    }

    function openNetwork() {
        Quickshell.execDetached(["iwgtk"]);
    }

    function toggleDoNotDisturb() {
        doNotDisturb = !doNotDisturb;
        Quickshell.execDetached(["swaync-client", doNotDisturb ? "-dn" : "-df"]);
    }

    function toggleGameMode() {
        if (animationQuery.running || animationWrite.running) return;
        requestedGameMode = !gameMode;
        if (gameMode) {
            writeAnimations(savedAnimationValue);
        } else {
            queriedAnimationValue = null;
            animationQuery.running = true;
        }
    }

    function writeAnimations(value) {
        animationWrite.command = ["hyprctl", "keyword", "animations:enabled", String(value)];
        animationWrite.running = true;
    }

    function refreshControls() {
        if (!brightnessQuery.running && !brightnessWrite.running && !brightnessWritePending)
            brightnessQuery.running = true;
        if (!dndQuery.running) dndQuery.running = true;
    }

    // Coalesce slider events and serialize writes so old values cannot finish last.
    property Timer brightnessThrottle: Timer {
        interval: 80
        onTriggered: {
            if (root.brightnessWrite.running || !root.brightnessWritePending) return;
            root.brightnessWritePending = false;
            root.brightnessWrite.command = ["brightnessctl", "set", Math.round(root.brightness * 100) + "%"];
            root.brightnessWrite.running = true;
        }
    }

    property Process brightnessWrite: Process {
        onExited: {
            if (root.brightnessWritePending) root.brightnessThrottle.restart();
        }
    }

    property Process brightnessQuery: Process {
        command: ["brightnessctl", "-m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const match = text.match(/(\d+)%/);
                if (match && !root.brightnessWritePending && !root.brightnessWrite.running)
                    root.brightness = Number(match[1]) / 100;
            }
        }
    }

    property Process animationQuery: Process {
        command: ["hyprctl", "-j", "getoption", "animations:enabled"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const value = JSON.parse(text).int;
                    if (value === 0 || value === 1) root.queriedAnimationValue = value;
                } catch (error) {
                    console.warn("Island: unable to read animation setting:", error);
                }
            }
        }
        onExited: (exitCode) => {
            if (exitCode !== 0 || root.queriedAnimationValue === null) return;
            root.savedAnimationValue = root.queriedAnimationValue;
            root.writeAnimations(0);
        }
    }

    property Process animationWrite: Process {
        onExited: (exitCode) => {
            if (exitCode !== 0) return;
            root.gameMode = root.requestedGameMode;
            if (!root.gameMode) root.savedAnimationValue = null;
        }
    }

    property Process dndQuery: Process {
        command: ["swaync-client", "-D"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.doNotDisturb = text.trim().toLowerCase() === "true"
        }
    }

}
