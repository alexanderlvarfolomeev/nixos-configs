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
    implicitWidth: 60
    // Layout.preferredWidth: 60
    // Layout.fillHeight: true
    bottomRightRadius: 15
    bottomLeftRadius: 15
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#8806ce" }
        GradientStop { position: 0.1; color: "#823ec5" }
        GradientStop { position: 0.4; color: "#0097d8" }
        GradientStop { position: 0.85; color: "#823ec5" }
        GradientStop { position: 1.0; color: "#8806ce" }
    }

    Text {
        id: powerIcon
        anchors.centerIn: parent
        text: String.fromCodePoint(...KeyboardLayout.currentLayoutCode.toUpperCase().split('').map(c => 127397 + c.charCodeAt()))
        font.pixelSize: 24
        font.bold: true
        font.family: "JetBrains Mono NF"
        color: "black"
    }
}