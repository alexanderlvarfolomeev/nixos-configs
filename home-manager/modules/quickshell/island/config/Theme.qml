pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property color background: "#ee090b10"
    readonly property color raised: "#ff151820"
    readonly property color raisedHover: "#ff1d222c"
    readonly property color surface: "#ff11141a"
    readonly property color border: "#28ffffff"
    readonly property color borderStrong: "#45ffffff"
    readonly property color text: "#fff5f6fa"
    readonly property color textMuted: "#ff979ca8"
    readonly property color accent: "#ff88a9ff"
    readonly property color accentSoft: "#284f74d8"
    readonly property color success: "#ff82d8a6"
    readonly property color warning: "#fff3c978"

    readonly property string fontFamily: "Noto Sans"
    readonly property string monoFamily: "JetBrainsMono Nerd Font Propo"
    readonly property string iconFamily: "Material Symbols Rounded"

    readonly property int compactWidth: 238
    readonly property int compactHeight: 36
    readonly property int controlWidth: 366
    readonly property int controlHeight: 408
    readonly property int launcherWidth: 390
    readonly property int launcherHeight: 326
    readonly property int settingsWidth: 650
    readonly property int settingsHeight: 492
    readonly property int animationDuration: 260
    readonly property int cornerRadius: 24
}
