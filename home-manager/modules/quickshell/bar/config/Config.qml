pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property int barHeight: 40
    readonly property string barColor: "#2620242b"

    readonly property string hoveredTransparency: "#40000000"

    readonly property real fontSize: 20
    readonly property string fontFamily: "JetBrainsMono Nerd Font Propo"

    readonly property real timeVerticalMargin: 2
    readonly property real timeFontSize: 24
    readonly property string timeTextColor: "#e6e6fa"
    readonly property string timeOuterColor: "#00b4d8"
    readonly property string timeInnerColor: "#0071c5"
    readonly property var timeBgGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
            position: 0.0
            color: root.timeOuterColor
        }
        GradientStop {
            position: 0.3
            color: root.timeInnerColor
        }
        GradientStop {
            position: 0.7
            color: root.timeInnerColor
        }
        GradientStop {
            position: 1.0
            color: root.timeOuterColor
        }
    }

    readonly property real languageFontSize: 24
    readonly property string languageOuterColor: "#8806ce"
    readonly property string languageMiddleColor: "#823ec5"
    readonly property string languageInnerColor: "#0097d8"
    readonly property var languageBgGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
            position: 0.0
            color: root.languageOuterColor
        }
        GradientStop {
            position: 0.1
            color: root.languageMiddleColor
        }
        GradientStop {
            position: 0.4
            color: root.languageInnerColor
        }
        GradientStop {
            position: 0.85
            color: root.languageMiddleColor
        }
        GradientStop {
            position: 1.0
            color: root.languageOuterColor
        }
    }

    readonly property string audioBgColor: "#00449a"
    readonly property string audioTextColor: "#ff7900"
    readonly property string audioMutedTextColor: "#cc241d"

    readonly property string batteryBgColor: "#8806ce"
    readonly property string batteryTextColor: "#ffd700"

    readonly property real bluetoothFontSize: 28
    readonly property string bluetoothBgColor: "#0071c5"
    readonly property string bluetoothTextColor: "#c6e800"

    readonly property string networkBgColor: "#00b4d8"
    readonly property string networkTextColor: "#e6e6fa"

    // Shared colors for both the bar and island.
    readonly property color panelColor: "#c0003b5b"
    readonly property color surfaceColor: "#20242b"
    readonly property color mutedTextColor: "#69b1e2"
    readonly property color activeTextColor: "#241b20"
}
