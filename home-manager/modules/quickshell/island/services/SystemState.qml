import QtQuick
import Quickshell
import Quickshell.Bluetooth as BT
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

QtObject {
    id: root

    property date now: new Date()
    readonly property string clock: Qt.formatTime(now, "HH:mm")
    readonly property string dateLabel: Qt.formatDate(now, "ddd, d MMM")

    property var sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? false

    property var bluetoothAdapter: BT.Bluetooth.defaultAdapter
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
    property bool doNotDisturb: false
    property bool gameMode: false
    property string keyboardLayout: "--"
    property bool keyboardRefreshPending: false

    readonly property var players: Mpris.players.values
    readonly property var activePlayer: players.find(player => player.isPlaying) ?? players[0] ?? null
    readonly property string mediaTitle: (activePlayer?.trackTitle ?? "Nothing playing") || "Nothing playing"
    readonly property string mediaArtist: (activePlayer?.trackArtist ?? "") || ""
    readonly property bool mediaPlaying: activePlayer?.isPlaying ?? false

    function setVolume(nextVolume) {
        if (!sink?.audio) return;
        sink.audio.volume = Math.max(0, Math.min(1, nextVolume));
    }

    function toggleMute() {
        if (sink?.audio) sink.audio.muted = !sink.audio.muted;
    }

    function setBrightness(nextBrightness) {
        brightness = Math.max(0.01, Math.min(1, nextBrightness));
        Quickshell.execDetached(["brightnessctl", "set", Math.round(brightness * 100) + "%"]);
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
        gameMode = !gameMode;
        Quickshell.execDetached(["hyprctl", "keyword", "animations:enabled", gameMode ? "0" : "1"]);
    }

    function toggleMedia() {
        if (activePlayer?.canTogglePlaying) activePlayer.togglePlaying();
    }

    function previousMedia() {
        if (activePlayer?.canGoPrevious) activePlayer.previous();
    }

    function nextMedia() {
        if (activePlayer?.canGoNext) activePlayer.next();
    }

    function updateKeyboardLayout(layoutName) {
        const name = (layoutName ?? "").trim().toLowerCase();
        if (name.includes("russian") || name === "ru") {
            keyboardLayout = "RU";
        } else if (name.includes("english") || name.includes("us") || name === "en") {
            keyboardLayout = "EN";
        } else if (name.length > 0) {
            keyboardLayout = name.substring(0, 2).toUpperCase();
        }
    }

    function refreshKeyboard() {
        if (keyboardQuery.running) {
            keyboardRefreshPending = true;
        } else {
            keyboardQuery.running = true;
        }
    }

    property Timer clockTimer: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    property PwObjectTracker pipewireTracker: PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    property Process brightnessQuery: Process {
        command: ["brightnessctl", "-m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const match = text.match(/(\d+)%/);
                if (match) root.brightness = Number(match[1]) / 100;
            }
        }
    }

    property Process keyboardQuery: Process {
        command: ["hyprctl", "-j", "devices"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const devices = JSON.parse(text);
                    const keyboards = devices.keyboards ?? [];
                    const keyboard = keyboards.find(item => item.main === true) ?? keyboards[0];
                    if (keyboard) root.updateKeyboardLayout(keyboard.active_keymap);
                } catch (error) {
                    console.warn("Island: unable to read keyboard layout:", error);
                }
            }
        }

        onExited: {
            if (root.keyboardRefreshPending) {
                root.keyboardRefreshPending = false;
                running = true;
            }
        }
    }

    property Process dndQuery: Process {
        command: ["swaync-client", "-D"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.doNotDisturb = text.trim().toLowerCase() === "true"
        }
    }

    property Connections hyprlandEvents: Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const separator = event.data.indexOf(",");
                root.updateKeyboardLayout(separator >= 0 ? event.data.substring(separator + 1) : event.data);
            } else if (event.name === "configreloaded") {
                root.refreshKeyboard();
            }
        }
    }
}
