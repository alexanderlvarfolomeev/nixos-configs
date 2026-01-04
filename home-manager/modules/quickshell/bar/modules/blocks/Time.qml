import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    // Layout.preferredHeight: parent.implicitHeight - 2 * 2
    // Layout.preferredWidth: timeText.implicitWidth + 30 * 2 // + padding * 2
    // Layout.minimumWidth: 130
    // Layout.maximumWidth: 130
    // anchors.fillHeight: true
    anchors {
        topMargin: 2.0
        bottomMargin: 2.0
        top: parent.top
        bottom: parent.bottom
    }
    // anchors.verticalCenter: parent.verticalCenter
    // implicitHeight: parent.implicitHeight - 2 * 2 // + margin * 2
    width: 130
    // Layout.topMargin: 2.0
    // Layout.bottomMargin: 2.0
    // Layout.fillHeight: true
    // Layout.alignment: Qt.AlignHCenter

    color: "transparent"
    radius: 20

    Rectangle {
        id: transparentGradient
        opacity: 0.8
        radius: parent.radius
        // Layout.fillHeight: true
        // Layout.fillWidth: true
        // Layout.alignment: Qt.AlignBaseline
        // Layout.preferredWidth: parent.implicitWidth
        // Layout.preferredHeight: parent.implicitHeight
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#00b4d8" }
            GradientStop { position: 0.3; color: "#0071c5" }
            GradientStop { position: 0.7; color: "#0071c5" }
            GradientStop { position: 1.0; color: "#00b4d8" }
        }
    }

    Text {
        id: timeTextShadow
        // Layout.alignment: Qt.AlignBaseline
        // Layout.topMargin: 2.0
        // Layout.leftMargin: 2.0
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 2.0
        anchors.verticalCenterOffset: 2.0
        text: TimeTimer.time
        font.pixelSize: 24
        font.bold: true
        font.family: "JetBrains Mono NF"
        color: "black"
    }

    Text {
        id: timeText
        // Layout.alignment: Qt.AlignBaseline
        // center the bar in its parent component (the window)
        anchors.centerIn: parent
        text: TimeTimer.time
        font.pixelSize: 24
        font.bold: true
        font.family: "JetBrains Mono NF"
        color: "#e6e6fa"
    }
}