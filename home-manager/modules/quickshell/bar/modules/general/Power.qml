import Quickshell
import QtQuick
import qs.base as Base
import qs.config

Base.MouseRec {
    id: root
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    width: 66
    topLeftRadius: 5
    bottomLeftRadius: 20
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#8806ce" }
        GradientStop { position: 1.0; color: (root.hovered ? "#0071c5" : "#00b4d8") }
    }

    Text {
        id: powerIcon
        anchors.centerIn: parent
        text: "⏻"
        font.pixelSize: 24
        font.bold: true
        font.family: Config.fontFamily
        color: "black"
    }

    onClicked: function() {
        Quickshell.execDetached(["wlogout", "-b", "2"])
    }

}
