import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts


Row {
    id: root
    spacing: 3

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    Battery {}
}