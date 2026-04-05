import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.base
import qs.config

MouseRec {
  id: root

  anchors {
      top: parent.top
      bottom: parent.bottom
      topMargin: 2.0
      bottomMargin: 2.0
  }
  width: audioText.width + 10 * 2
  color: root.hovered ? Qt.darker(Config.audioBgColor, 1.1) : Config.audioBgColor

  StyledText {
    id: audioText

    anchors.centerIn: parent

    color: AudioSingleton.sinkStateColor(AudioSingleton.sink?.audio)
    text: AudioSingleton.sinkStateText(AudioSingleton.sink?.audio)
  }

  onClicked: function() {
    pavucontrol.startDetached()
  }

  Process {
    id: pavucontrol
    running: false
    command: ["bash",  "/home/aorise/.local/scripts/toggle.sh", "pavucontrol"]
  }
}