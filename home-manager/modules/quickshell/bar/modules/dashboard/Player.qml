import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../utils"
import qs.config

Rectangle {
  id: root
  color: "transparent"

  readonly property real outerRadius: 10

  Rectangle {
    id: wrapper

    color: "#d1f1ff"

    anchors.centerIn: parent
    implicitHeight: 0.95 * parent.implicitHeight
    implicitWidth: 0.95 * parent.implicitWidth

    topLeftRadius: root.outerRadius
    topRightRadius: root.outerRadius
    bottomLeftRadius: root.outerRadius
    bottomRightRadius: root.outerRadius

    ClippingRectangle {
      id: coverWrapper

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 10

      // anchors.left: parent.left
      // anchors.right: parent.right

      implicitWidth: 0.75 * parent.width
      implicitHeight: 0.75 * parent.width
      color: "gray"
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

    Text{
      id: title

      anchors.top: coverWrapper.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 10

      text: PlayerSingleton.title
      color: "black"
      font.pixelSize: 20
      font.bold: true
      font.family: "JetBrains Mono NF"
      elide: Text.ElideRight
      width: Math.min(titleInvisible.width, parent.implicitWidth - 16)
    }

    // Workaround to center short names. TODO: get rid of it somehow
    Text{
      id: titleInvisible

      anchors.top: coverWrapper.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 10

      text: PlayerSingleton.title
      color: "transparent"
      font.pixelSize: 20
      font.bold: true
      font.family: "JetBrains Mono NF"
    }

    Text{
      id: artist

      anchors.top: title.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: -2

      text: PlayerSingleton.artist
      color: "black"
      font.pixelSize: 16
      font.bold: true
      font.family: "JetBrains Mono NF"
      elide: Text.ElideRight
      // width: parent.implicitWidth - 16
    }

    Row {
      id: controlRow

      anchors.top: artist.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 2

      spacing: 10

      PlayerControl {
        onClicked: () => {
            console.log("Click control.");
            PlayerSingleton.active?.previous();
        }

        icon: "skip_previous"
        canUse: PlayerSingleton.active?.canGoPrevious ?? false
      }

      PlayerControl {
        onClicked: () => {
            console.log("Click control.");
            PlayerSingleton.active?.togglePlaying();
        }

        icon: PlayerSingleton.active?.isPlaying ? "pause" : "play_arrow"
        canUse: PlayerSingleton.active?.canTogglePlaying ?? false
      }

      PlayerControl {
        onClicked: () => {
            console.log("Click control.");
            PlayerSingleton.active?.next();
        }

        icon: "skip_next"
        canUse: PlayerSingleton.active?.canGoNext ?? false
      }
    }
  }
}