import QtQuick
import qs.modules.island.config

Rectangle {
    id: root
    property color tint: Theme.background
    property real tintOpacity: 0.28

    color: Qt.rgba(tint.r, tint.g, tint.b, tintOpacity)
    border.width: 1
    border.color: "#40ffffff"

    // Native scene-graph gradients add a glossy rim without screen capture,
    // an offscreen shader pass, or a continuously running animation.
    Rectangle {
        anchors.fill: parent
        radius: root.radius
        gradient: Gradient {
            GradientStop { position: 0; color: "#28ffffff" }
            GradientStop { position: 0.32; color: "#06ffffff" }
            GradientStop { position: 0.58; color: "#00ffffff" }
            GradientStop { position: 1; color: "#18000000" }
        }
    }

    Rectangle {
        anchors { fill: parent; margins: 1 }
        radius: Math.max(0, root.radius - 1)
        color: "transparent"
        border.width: 1
        border.color: "#16ffffff"
    }

    Rectangle {
        anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }
        width: Math.max(0, parent.width - root.radius * 2)
        height: 1
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: "#00ffffff" }
            GradientStop { position: 0.5; color: "#90ffffff" }
            GradientStop { position: 1; color: "#00ffffff" }
        }
    }
}
