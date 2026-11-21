pragma Singleton

import QtQuick
import Quickshell

Singleton {
    // Match qsbar's dashboard, workspace and device colors.
    readonly property color background: "#c0003b5b"
    readonly property color raised: "#00449a"
    readonly property color raisedHover: "#0071c5"
    readonly property color surface: "#20242b"
    readonly property color border: "#8000b4d8"
    readonly property color borderStrong: "#00b4d8"
    readonly property color text: "#e6e6fa"
    readonly property color textMuted: "#69b1e2"
    readonly property color accent: "#00b4d8"
    readonly property color accentSoft: "#2800b4d8"
    readonly property color activeText: "#241b20"
    readonly property color workspaceActive: "#0071c5"
    readonly property color workspaceHover: "#c0003b5b"
    readonly property color workspaceAppsActive: "#90ffffff"
    readonly property color workspaceApps: "#50ffffff"
    readonly property color success: "#ff82d8a6"
    readonly property color warning: "#fff3c978"

    readonly property string fontFamily: "JetBrainsMono Nerd Font Propo"
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
