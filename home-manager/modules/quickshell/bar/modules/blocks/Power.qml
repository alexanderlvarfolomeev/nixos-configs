import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    width: 66
    // Layout.preferredWidth: 66
    // Layout.fillHeight: true
    topLeftRadius: 5
    bottomLeftRadius: 20
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#8806ce" }
        GradientStop { position: 1.0; color: "#00b4d8" }
    }

    Text {
        id: powerIcon
        anchors.centerIn: parent
        text: "⏻"
        font.pixelSize: 24
        font.bold: true
        font.family: "JetBrains Mono NF"
        color: "black"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: function() {
            wlogout.running = true
        }
        hoverEnabled: true
    }

    Process {
        id: wlogout
        running: false
        command: [ "wlogout", "-b", "2"]
    }
}