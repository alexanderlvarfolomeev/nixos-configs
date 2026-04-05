import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.base
import qs.config

Rectangle {
  id: root
  color: "transparent"

  readonly property real outerRadius: Config.dashboardBorderRadius

  Rectangle {
    id: wrapper

    color: Config.playerBgColor

    anchors.centerIn: parent
    implicitHeight: Config.dashboardInnerContainerRatio * parent.implicitHeight
    implicitWidth: Config.dashboardInnerContainerRatio * parent.implicitWidth

    radius: Config.dashboardBorderRadius

    ClippingRectangle {
      id: coverWrapper

      anchors {
        top: parent.top
        topMargin: 10
        horizontalCenter: parent.horizontalCenter
      }

      implicitWidth: Config.playerCoverRatio * parent.width
      implicitHeight: Config.playerCoverRatio * parent.width
      color: Config.playerCoverPlaceholderColor
      radius: Infinity

      Image {
        id: cover

        anchors.fill: parent

        source: PlayerSingleton.artUrl
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: width
        sourceSize.height: height
      }
    }

    StyledText{
      id: title

      anchors {
        top: coverWrapper.bottom
        topMargin: 10
        horizontalCenter: parent.horizontalCenter
      }

      text: PlayerSingleton.title
      color: Config.playerTitleColor
      elide: Text.ElideRight
      width: Math.min(titleInvisible.width, parent.implicitWidth - 16)
    }

    // Workaround to center short names. TODO: get rid of it somehow
    StyledText{
      id: titleInvisible

      anchors {
        top: coverWrapper.bottom
        topMargin: 10
        horizontalCenter: parent.horizontalCenter
      }

      text: PlayerSingleton.title
      color: "transparent"
    }

    StyledText{
      id: artist

      anchors {
        top: title.bottom
        topMargin: -2
        horizontalCenter: parent.horizontalCenter
      }

      text: PlayerSingleton.artist
      color: Config.playerTitleColor
      font.pixelSize: Config.playerArtistFontSize
    }

    Row {
      id: controlRow

      anchors {
        top: artist.bottom
        topMargin: 2
        horizontalCenter: parent.horizontalCenter
      }

      spacing: 10

      PlayerControl {
        onClicked: () => {
            PlayerSingleton.active?.previous();
        }

        icon: "skip_previous"
        canUse: PlayerSingleton.active?.canGoPrevious ?? false
      }

      PlayerControl {
        onClicked: () => {
            PlayerSingleton.active?.togglePlaying();
        }

        icon: PlayerSingleton.active?.isPlaying ? "pause" : "play_arrow"
        canUse: PlayerSingleton.active?.canTogglePlaying ?? false
      }

      PlayerControl {
        onClicked: () => {
            PlayerSingleton.active?.next();
        }

        icon: "skip_next"
        canUse: PlayerSingleton.active?.canGoNext ?? false
      }
    }
  }
}