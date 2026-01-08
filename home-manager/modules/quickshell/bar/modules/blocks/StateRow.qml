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

    // I don't need it
    // Tray {}

    // AllWindows {}

    // Wlr {}

    Network {}

    Audio {}

    Battery {}
}