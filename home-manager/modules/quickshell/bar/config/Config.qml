pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property int barHeight: 40
  readonly property string barColor: "#2620242b"

  readonly property string hoveredTransparency: "#40000000"

  readonly property real materialTextFont: 32

  readonly property real fontSize: 20
  readonly property string fontFamily: "JetBrainsMono Nerd Font Propo"


  readonly property real timeVerticalMargin: 2
  readonly property real timeFontSize: 24
  readonly property string timeTextColor: "#e6e6fa"
  readonly property string timeOuterColor: "#00b4d8"
  readonly property string timeInnerColor: "#0071c5"
  readonly property var timeBgGradient: Gradient {
    orientation: Gradient.Horizontal
    GradientStop { position: 0.0; color: timeOuterColor }
    GradientStop { position: 0.3; color: timeInnerColor }
    GradientStop { position: 0.7; color: timeInnerColor }
    GradientStop { position: 1.0; color: timeOuterColor }
  }

  readonly property real languageFontSize: 24
  readonly property string languageOuterColor: "#8806ce"
  readonly property string languageMiddleColor: "#823ec5"
  readonly property string languageInnerColor: "#0097d8"
  readonly property var languageBgGradient: Gradient {
    orientation: Gradient.Horizontal
    GradientStop { position: 0.0; color: languageOuterColor }
    GradientStop { position: 0.1; color: languageMiddleColor }
    GradientStop { position: 0.4; color: languageInnerColor }
    GradientStop { position: 0.85; color: languageMiddleColor }
    GradientStop { position: 1.0; color: languageOuterColor }
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

  readonly property real dashboardHeight: 332
  readonly property real dashboardSinglePartWidth: 270 
  readonly property real dashboardBorderRadius: 10
  readonly property real dashboardInnerContainerRatio: 0.95
  readonly property string dashboardBgColor: "#c0003b5b"
  readonly property string dashboardBorderColor: "#00b4d8"
  readonly property real dashboardBorderWidth: 2

  readonly property real playerControlRadius: 5
  readonly property real playerControlSpacing: 10
  readonly property string playerControlActiveColor: "black"
  readonly property string playerControlInactiveColor: "gray"

  readonly property string playerBgColor: "#d1f1ff"
  readonly property real playerCoverRatio: 0.75
  readonly property string playerCoverPlaceholderColor: "gray"
  readonly property string playerTitleColor: "black"
  readonly property real playerTitlePadding: 8
  readonly property real playerCoverVerticalMargin: 10
  readonly property real playerArtistFontSize: 16

  readonly property real resourcesControlRadius: 5
  readonly property string resourcesBgColor: "#0071c5"
  readonly property string resourcesInnerBgColor: "#A0FFFFFF"
  readonly property string resourcesTextColor: "black"
  readonly property real resourcesInnerVerticalPadding: 4
  readonly property real resourcesTitleFontSize: 24
  readonly property real resourcesTextSpacing: 10

  readonly property real userControlRadius: 5
  readonly property string userBgColor: "#69b1e2"
  readonly property string userInnerBgColor: "#A0FFFFFF"
  readonly property string userTextColor: "black"
  readonly property real userInnerVerticalPadding: 4
  readonly property real userTextSpacing: 10
}
