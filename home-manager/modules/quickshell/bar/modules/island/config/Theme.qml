pragma Singleton

import QtQuick
import Quickshell
import qs.config

Singleton {
    // Match qsbar's dashboard, workspace and device colors.
    readonly property color background: Config.panelColor
    readonly property color raised: Config.audioBgColor
    readonly property color raisedHover: Config.bluetoothBgColor
    readonly property color surface: Config.surfaceColor
    readonly property color border: "#8000b4d8"
    readonly property color borderStrong: Config.networkBgColor
    readonly property color text: Config.timeTextColor
    readonly property color textMuted: Config.mutedTextColor
    readonly property color accent: Config.networkBgColor
    readonly property color accentSoft: "#2800b4d8"
    readonly property color activeText: Config.activeTextColor
    readonly property color workspaceActive: Config.bluetoothBgColor
    readonly property color workspaceHover: Qt.lighter(Config.bluetoothBgColor, 1.2)
    readonly property color workspaceAppsActive: "#90ffffff"
    readonly property color workspaceApps: "#50ffffff"
    readonly property color success: "#ff82d8a6"
    readonly property color warning: "#fff3c978"

    readonly property string fontFamily: Config.fontFamily
    readonly property string monoFamily: Config.fontFamily
    readonly property string iconFamily: "Material Symbols Rounded"

    readonly property int compactWidth: 238
    readonly property int compactHeight: 36
    readonly property int controlWidth: 366
    readonly property int controlHeight: 408
    readonly property int launcherWidth: 390
    readonly property int launcherHeight: 326
    readonly property int animationDuration: 260
    readonly property int cornerRadius: 24
}
